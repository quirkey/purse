require 'test_helper.rb'

class TestPursePocket < Test::Unit::TestCase

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