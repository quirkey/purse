require 'test_helper.rb'

class TestNote < Test::Unit::TestCase

  context "Purse" do
    context "Note" do

      context "an instance" do        
        setup do
          @path = purse_path
          @note = Note.new(@path, 'sander', 'Nonsense', :method => :blowfish, :store_as => :yaml)
        end

        context "new" do

          should "require path" do
            assert_raise(MissingParameter) do
              Note.new(nil,'sander','Sander nonsense')
            end
          end

          should "require name" do
            assert_raise(MissingParameter) do
              Note.new(purse_path, '', 'Sander nonsense')
            end
          end

          context "initializing with regular data" do
            should "set @path" do
              assert_equal @path, @note.path
            end

            should "set @name" do
              assert_equal 'sander', @note.name
            end

            should "set @data" do
              assert_equal 'Nonsense', @note.data
            end

            should "save extra args as options" do
              assert @note.options.is_a?(Hash)
              assert_equal :blowfish, @note.options[:method]
            end
          end

          context "initializing with encrypted data" do
            setup do
              @note = Note.new(purse_path, 'sander', 'ENCRYPTED DATA', :encrypted => true)
            end

            should "set @path" do
              assert_equal purse_path, @note.path
            end

            should "set @name" do
              assert_equal 'sander', @note.name
            end

            should "not set @data" do
              assert_nil @note.data
            end

            should "set @encrypted" do
              assert_equal 'ENCRYPTED DATA', @note.encrypted
            end
          end
        end

        context "file_name" do
          should "return #name.note" do
            assert_equal @note.name + '.note', @note.file_name
          end
        end

        context "file_path" do
          should "return path/name.note" do
            assert_equal File.join(@note.path, @note.name + '.note'), @note.file_path
          end
        end

        context "save" do

          should "require password" do
            assert_raise(MissingParameter) do
              @note.save(nil)
            end
          end

          context "with password" do
            setup do
              @password = '12345' 
              Crypt::Blowfish.any_instance.expects(:encrypt_string).with(@note.data).returns('ENCRYPTED DATA')
              @note.save(@password)
            end

            should "encrypt data and place in @encrypted" do
              assert_equal 'ENCRYPTED DATA', @note.encrypted
            end

            should "write to file in path with #name" do
              assert File.readable?(@note.file_path)
              assert_equal @note.encrypted, File.read(@note.file_path)
            end

            # teardown do
            #   File.unlink(purse_path, 'sander')
            # end
          end
        end

        context "encrypt" do
          # blowfish = Crypt::Blowfish.new("A key up to 56 bytes long")
          # plainBlock = "ABCD1234"
          # encryptedBlock = blowfish.encrypt_block(plainBlock)
          # decryptedBlock = blowfish.decrypt_block(encryptedBlock)

          should "require password" do
            assert_raise(MissingParameter) do
              @note.encrypt(nil)
            end
          end
          
          context "with password" do
            setup do
              @password = 'Test123'
              Crypt::Blowfish.any_instance.expects(:encrypt_string).with(@note.data).returns('ENCRYPTED DATA')
              @note.encrypt(@password)
            end

            should "save encrypted data to encrypted" do
              assert_equal 'ENCRYPTED DATA', @note.encrypted
            end
          end
        end

        context "decrypt" do
          setup do
            @note = Note.new(purse_path, 'sander', 'ENCRYPTED DATA', :encrypted => true)
          end

          should "require password" do
            assert_raise(MissingParameter) do
              @note.decrypt(nil)
            end
          end

          context "with password" do
            setup do
              @password = 'Test123'
              Crypt::Blowfish.any_instance.expects(:decrypt_string).with(@note.encrypted).returns('Nonsense')
              @note.decrypt(@password)
            end

            should "save decrypted data to @data" do
              assert_equal 'Nonsense', @note.data
            end
          end
        end
      end

      context "on the class" do
        context "load" do

          should "require path" do
            assert_raise(MissingParameter) do
              Note.load(nil, 'sander')
            end
          end

          should "name" do
            assert_raise(MissingParameter) do
              Note.load(nil, 'sander')
            end
          end

          should "raise error if file can not be found" do
            assert_raise(MissingFile) do
              Note.load(purse_path, "file_#{rand(5)}")
            end
          end

          context "with a saved encrypted file" do
            setup do
              # Crypt::Blowfish.any_instance.expects(:decrypt_block).with('ENCRYPTED DATA').returns('Nonsense')
              @note = Note.load(purse_path, 'sander')
            end

            should "return Note" do
              assert @note.is_a?(Note)
            end

            should "set @encrypted" do
              assert_equal 'ENCRYPTED DATA', @note.encrypted
            end

            should "not set @data" do
              assert_nil @note.data
            end
          end
        end
      end
    end
  end

end