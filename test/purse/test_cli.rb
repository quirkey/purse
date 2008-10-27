require 'test_helper.rb'

class TestCli < Test::Unit::TestCase

  context "Purse" do
    context "Cli" do
      context "run" do
        setup do
          HighLine.any_instance.stubs(:say)
          @pocketname = 'test_purse_data'
        end
        
        # purse pursename #=> initialize or pull
        context "purse pursename" do
          should "call init" do
            Cli.expects(:init).with(@pocketname).once
            Cli.expects(:list_notes).with(@pocketname).once
            Cli.run([@pocketname])
          end
        end
        
        # purse pursename notename
        context "purse pursename notename" do
          context "if the note does not exist" do
            should "call init then call find and then edit" do
              notename = 'test123'
              Cli.expects(:init).with(@pocketname).once
              Cli.expects(:find).with(@pocketname,notename).once
              Cli.expects(:edit).with(@pocketname,notename).once
              Cli.run([@pocketname, notename])
            end
          end
          
          context "if the note exists" do
            should "call init then call find and then display" do
              notename = 'test123'
              Cli.expects(:init).with(@pocketname).once
              Cli.expects(:find).with(@pocketname,notename).once
              Cli.expects(:display).once
              Cli.run([@pocketname, notename])
            end
          end
        end
        
        # purse pursename notename --edit #=> open in EDITOR save and push
        context "purse pursename notename --edit" do
          should "call init then call find and then edit" do
            notename = 'test123'
            Cli.expects(:init).with(@pocketname).once
            Cli.expects(:find).with(@pocketname,notename).once
            Cli.expects(:edit).with(@pocketname,notename).once
            Cli.run([@pocketname, notename])
          end
        end
        
        # purse pursename push
        # purse pursename pull
        # purse settings/ purse # rerun settings 
        
        
      end
    end
  end
end