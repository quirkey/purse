require 'test_helper.rb'

class TestPocket < Test::Unit::TestCase

  context "Purse" do
    context "Pocket" do

      context "an instance" do
        setup do
          @pocket = Pocket.new(purse_path)
        end

        should "require a path" do
          assert_raise(MissingParameter) do
            Pocket.new(nil)
          end
        end

        context "initialize" do

          should "assign path to @path" do
            assert purse_path, @pocket.path
          end

        end
        context "notes" do

          setup do
            @notes = @pocket.notes
          end

          should "find notes by Dir[]" do
            assert Dir[purse_path + '/*.note'], @pocket.notes_paths
          end

          should "assign notes to an array in @notes" do
            assert_set_of Note, @notes
          end
        end

        context "find" do
          setup do
            Dir.expects(:[]).at_most_once.returns([File.join(purse_path, 'jagger.note')])
            @notes = @pocket.notes
          end

          context "with a loaded note name" do
            setup do
              @note = @pocket.find('jagger')
            end

            should "return the note" do
              assert @note.is_a?(Note)
              assert_equal 'jagger', @note.name
            end
          end

          context "with an unknown note" do            
            should "raise error" do
              assert_raise(MissingFile) do
                @pocket.find('bloober')
              end
            end
          end
        end
        
        context "edit" do
          should "yield the note to the block" do
            @pocket.edit('jagger') do |note|
              assert note.is_a?(Note)
              assert_equal @pocket.find('jagger'), note
            end
          end
        end

        context "re_encrypt" do
          should "require a password" do
            assert_raise(MissingParameter) do
              @pocket.re_encrypt(nil)
            end
          end

          context "with a password" do            
            should "call save on each note" do
              password = 'newpass'
              Note.any_instance.stubs(:save).times(3).with(password)
              @pocket.re_encrypt(password)
            end
          end

        end

        context "init" do
          context "if the directory already exists" do
            context "if the git directory already exists" do
              should "not call Git init" do
                Git.init(purse_path)
                Git.expects(:init).once
                @pocket.init
                FileUtils.rm_rf(File.join(purse_path, '.git'))
              end
            end

            context "if the git directory does not exist" do
              should "initialize the git repo" do
                Git.expects(:init).with(purse_path).once
                @pocket.init
                # assert File.readable?(File.join(purse_path, '.git/config'))
                FileUtils.rm_rf(File.join(purse_path, '.git'))
              end
            end            
          end

          context "if the directory doesn't exist" do
            setup do
              @other_purse_path = File.expand_path(File.join('~', 'tmp', 'tmp_purse_path'))
              @pocket = Pocket.new(@other_purse_path)
              Git.expects(:init).with(@other_purse_path).once
              @pocket.init
            end
            
            teardown do
              FileUtils.rm_rf(@other_purse_path)
            end
            
            should "create the directory" do
              assert File.readable?(@other_purse_path)
            end

            should "create the git directory" do
              assert File.directory?(File.join(@other_purse_path, '.git'))
            end
          end

        end

        context "push" do
          context "if there is already a git directory" do

          end

          context "if there is no git remote setting" do

          end

          context "if there is a remote setting but there is no repository" do

          end

          should_eventually "push to git repo" do

          end

        end

        context "pull" do

          should_eventually "pull from a git server" do

          end

        end
      end
    end
  end


end