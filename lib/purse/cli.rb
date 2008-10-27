module Purse
  class Cli

    # purse pursename #=> initialize or pull
    # purse pursename notename #=> pocket.find(notename) if it doesnt exist first pull then ask if you want to create it
    # purse pursename notename --edit #=> open in EDITOR save and push
    # purse pursename push
    # purse pursename pull
    # purse settings/ purse # rerun settings 
    class << self
      def run(args)
        pocket_name = args.shift
        note_name   = args.shift
        action      = args.shift
        banner
        if pocket_name == 'settings' || pocket_name.nil?
          settings
        elsif action
          send(action.gsub('--',''), pocket_name, note_name)
        else
          case note_name
          when 'push'
            push(pocket_name)
          when 'pull'
            pull(pocket_name)
          when '' 
          when nil
            list_notes(pocket_name)
          else
            find(pocket_name, note_name)
          end
        end 
      end

      protected
      def settings
        h1('Setup utility')
        hr
        say("loading settings from : #{Settings.path}")
        Settings.load
        settings = {}
        settings[:root_path] = cli.ask("Root Path for pockets? ") {|q| q.default = Settings.get(:root_path) || File.join(File.expand_path('~'), '.purse', 'pockets') }
        settings[:editor]    = cli.ask("Editor for notes? ") {|q| q.default = Settings.get(:editor) || 'vim' }
        hr
        say("saving settings to : #{Settings.path}")
        Settings.settings = settings
      end
              
      def init(pocket_name)
        pocket = Pocket.new(pocket_path(pocket_name))
        pocket.init
        pocket
      end
      
      def find(pocket_name, note_name)
        say("loading note #{pocket_name}/#{note_name}")
        hr
        pocket = init(pocket_name)
        note = pocket.find(note_name)
        decrypt(note)
        display(note)
      rescue MissingFile
        say("could not find note: #{pocket_name}/#{note_name}")
        if cli.agree("would you like to create it? (y/n)")
          edit(pocket_name, note_name)
        end
      end
      
      def display(note)
        h1("Note: #{note.name}",:green)
        hr
        say(note.data)
        hr
      end
      
      def save(note)
        password = cli.ask("Password: ") { |q| q.echo = false }
        note.save(password)
      end

      def decrypt(note)
        return unless note.encrypted?
        password = cli.ask("Password: ") { |q| q.echo = false }
        note.decrypt(password)
      end
      
      def edit(pocket_name, note_name)
        say("loading note #{pocket_name}/#{note_name}")
        hr
        pocket = init(pocket_name)
        pocket.edit(note_name) do |note|
          decrypt(note)
          tmp_path = empty_temp_path
          File.open(tmp_path, 'w') {|f| f << note.data }
          execute("#{editor} #{tmp_path}")
          sleep(2)
          data = ""
          File.open(tmp_path, 'r') {|f| data << f.read }
          note.data = data
          hr
          say("saving note #{pocket_name}/#{note_name}")
          save(note)
        end
      end
      
      def push(pocket_name)
        pocket = init(pocket_name)
        say("Committing local changes for #{pocket_name}")
        pocket.commit
        hr
        set_remote(pocket_name)
        say("Pulling changes from remote (#{pocket.remote})")
        pocket.pull
        hr
        say("Pushing changes to remote (#{pocket.remote})")
        pocket.push
      end
      
      def pull(pocket_name)
        pocket = init(pocket_name)
        say("Committing local changes for #{pocket_name}")
        pocket.commit
        hr
        set_remote(pocket_name)
        say("Pulling changes from remote (#{pocket.remote})")
        pocket.pull
        hr
      end
      
      def set_remote(pocket_name)
        pocket = init(pocket_name)
        unless pocket.remote
          remote_url = cli.ask("please enter your remote git url (git@github ...)")
          pocket.set_remote(remote_url)
          say("set remote to #{remote_url}")
        end
      end
      
      def list_notes(pocket_name)
        pocket = init(pocket_name)
        say("Notes in <%= color '(#{pocket_name})', :red %>")
        pocket.notes.each do |note| 
          say("- #{note.name}") 
        end
      end
      
      protected
      def pocket_path(pocket_name)
        File.join(Settings.get(:root_path), pocket_name)
      end
      
      def editor
        Settings.get(:editor)
      end
      
      def banner
        hr
        h1('/ Purse /', :white)
        hr
      end
      
      def h1(text, color = :red)
        say("<%= color('#{text}', :#{color}) %>")
      end 

      def hr(color = :magenta)
        say("<%= color('-' * 40, :#{color}) %>")
      end
      
      def say(message)
        cli.say(message)
      end
      
      def cli
        @cli ||= HighLine.new
      end
      
      def execute(command)
        `#{command}`
      end
      
      def random_temp_name
        "#{rand Time.now.to_i}-#{rand(1000)}--"
      end
      
      def empty_temp_path
        temp_dir = File.join(Settings.get(:root_path), 'tmp')
        FileUtils.mkdir_p(temp_dir)
        File.join(temp_dir, random_temp_name)
      end
    end
  end
end