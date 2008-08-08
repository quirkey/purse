require 'highline/import'

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
        if pocket_name == 'settings' || pocket_name.nil?
          settings
        elsif action
          send(action.gsub('--'), pocket_name, note_name)
        else
          case note_name
          when 'push'
            push pocket_name
          when 'pull'
            pull pocket_name
          when '' 
          when nil
            init pocket_name
          else
            find(pocket_name, note_name)
          end
        end 
      end

      protected
      def settings
        hr
        h1('Purse /', :white)
        h1('Setup utility')
        hr
        say("loading settings from : #{Settings.path}")
        Settings.load
        settings = {}
        settings[:root_path] = ask("Root Path for pockets? ") {|q| q.default = Settings.get(:root_path) || File.join(File.expand_path('~'), '.purse', 'pockets') }
        settings[:editor]    = ask("Editor for notes? ") {|q| q.default = Settings.get(:editor) || 'vim' }
        hr
        say("saving settings to : #{Settings.path}")
        Settings.settings = settings
        h1('Done', :yellow)
      end
              
      def init(pocket_name)
        
      end
      
      def find(pocket_name, note_name)
        
      end
      
      def edit(pocket_name, note_name)
      end
      
      def push(pocket_name)
      end
      
      def pull(pocket_name)
        
      end
      
      def h1(text, color = :red)
        say("<%= color('#{text}', :#{color}) %>")
      end 

      def hr(color = :magenta)
        say("<%= color('-' * 40, :#{color}) %>")
      end
    end
  end
end