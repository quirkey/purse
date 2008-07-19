require 'test_helper.rb'

class TestPurseNote < Test::Unit::TestCase

  context "Purse" do
    context "Note" do

      context "an instance" do
        context "initialize" do
          
          should "require path" do
            
          end
          
          should "require name" do
            
          end
          
          should "require data" do
            
          end
          
          should "require readable path" do
            
          end
        end

        context "save" do
          should "require password" do
            
          end
          
          should "encrypt data and place in @encrypted" do
            
          end
          
          should "write to file in path with #name" do
            
          end
        end
        
        context "encrypt" do
          
          should "use blowfish to encrypt data" do
            
          end
          
          should "save encrypted data to encrypted" do
            
          end
          
          should "require password" do
            
          end
          
        end
        
        context "decrypt" do
          
          should "use blowfish to decrypt data in @encrypted" do
            
          end
          
          should "save decrypted data to @data" do
            
          end
          
          should "require password" do
            
          end
        end
      end

      context "on the class" do
        context "load" do
          should "require path" do
            
          end
          
          should "require name" do
            
          end
          
          should "raise error if file can not be found" do
            
          end
          
          should "decrypt data" do
            
          end
          
          should "return Note" do
            
          end
        end
      end
    end
  end

end