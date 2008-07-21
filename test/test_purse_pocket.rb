require 'test_helper.rb'

class TestPursePocket < Test::Unit::TestCase
  
  context "Purse" do
    context "Pocket" do
      
      context "an instance" do
        setup do
        end
        
        should "require a path" do
          assert_raise(MissingParameter) do
            Pocket.new(nil)
          end
        end
        
        context "initialize" do
          should "assign path to @path" do

          end

          should "find notes by Dir[]" do

          end

          should "load all notes in path to @notes" do

          end

          should "assign notes to an array in @notes" do

          end
        end
        
        context "find" do
          
          context "with a loaded note name" do
            should "return the note" do

            end
          end
          
          context "with an unknown note" do
            should "raise error" do
              
            end
          end
        end
        
        context "re_encrypt" do
          should_eventually "load all files and re-encrpyt them with a new password" do
            
          end
        end
        
      end
    end
  end
  

end