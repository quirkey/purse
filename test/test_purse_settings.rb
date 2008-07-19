require 'test_helper.rb'

class TestPurseSettings < Test::Unit::TestCase

  context "Purse" do
    context "Settings" do
     
      context "path" do
        
        should "return readable file path" do
          
        end
        
        should "be a folder in ~/" do
          
        end
      end
      
      context "set_path" do
        
        should "accept a string" do
          
        end
        
        should "set path for class" do
          
        end
        
        context "with a BAD path" do
          should "raise error" do

          end
        end
      end
      
      context "load" do
        context "when the file already exists" do
          
          should "read from settings file" do
            
          end
          
          should "store parsed settings in @settings" do
            
          end
        end
        
        context "when the file does not exist" do
          
          should "create the file at path" do
            
          end
          
          should "initialize @settings" do
            
          end
          
        end
      end
      
      context "save" do
        
        should "convert @settings to_yaml" do
          
        end
        
        should "write yaml to path" do
          
        end
        
      end
            
      context "get" do
        context "if @settings are loaded" do
          
          should "retrieve setting by key" do
            
          end
        end
        
        context "if settings are not loaded" do
          should "load settings from path" do
            
          end
          
          should "retrieve setting by key" do
            
          end
        end
      end
     
      context "set" do
        should "put setting with key into @settings" do
          
        end
        
        should "save settings to path" do
          
        end
      end
    end
  end
end
