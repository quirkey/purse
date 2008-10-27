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
          send(action.gsub('--'), pocket_name, note_name)
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
        
        display(note)
      rescue MissingFile
        say("could not find note: #{pocket_name}/#{note_name}")
        if cli.agree("would you like to create it?")
          edit(pocket_name, note_name)
        end
      end
      
      def display(note)
        h1("Note: #{note.name}",:green)
        hr
        say(note.data)
      end
      
      def save(note)
        
      end
      
      def decrypt(note)
        return unless note.encypted?
        password = cli.ask("Password: ") { |q| q.echo = false }
        
      end
      
      def edit(pocket_name, note_name)
        say("loading note #{pocket_name}/#{note_name}")
        hr
        pocket = init(pocket_name)
        pocket.edit(note_name) do |note|
          
        end
      end
      
      def push(pocket_name)
      end
      
      def pull(pocket_name)
        
      end
      
      def list_notes(pocket_name)
        pocket = init(pocket_name)
        say("Notes in #{pocket_name}")
        cli.list(pocket.notes.collect {|n| n.name})
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
        h1('Purse /', :white)
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
    end
  end
end