require 'test_helper.rb'

class TestPurseSettings < Test::Unit::TestCase

  context "Purse" do
    context "Settings" do
     
      context "path" do
        setup do
          Settings.path = Settings.default_path
          @path = Settings.path
        end
        
        should "return readable file path" do
          assert File.readable?(@path)
        end
                
        should "be a file in ~/" do
          assert_match(/#{File.expand_path('~/')}/,@path)
        end
      end
      
      context "path=" do
        should_require 'path' do
          Settings.path = 12345
        end
        context "with a path string" do
        setup do
          Settings.path = File.join(purse_path, 'settings.yml')
        end
     
        should "set path for class" do
          assert_equal purse_path, Settings.path
        end        
      end
      end
      
      context "load" do
        context "when the file already exists" do
          setup do
            Settings.path = File.join(purse_path, 'settings.yml')
            YAML.expects(:load_file).with(File.join(purse_path, 'settings.yml'))
            Settings.load
          end
                    
          should "store parsed settings in @settings" do
            assert Settings.settings.is_a?(Hash)
            assert_equal 'github.com', Settings.settings[:repository]
          end
        end
        
        context "when the file does not exist" do
          setup do
            @other_path = File.join(purse_path, 'other_settings.yml')
            Settings.path = @other_path
            Settings.load
          end
          
          should "create the file at path" do
            assert File.readable?(@other_path)
          end
          
          should "initialize @settings" do
            assert Settings.settings.is_a?(Hash)
          end
          
          teardown do
            File.unlink(@other_path)
          end
        end
      end
      
      context "save" do        
        setup do
          @other_path = File.join(purse_path, 'other_settings.yml')
          Settings.path = @other_path
          Settings.settings = {:path => 'farts', :key => '12345'}
          Settings.save
        end
        
        teardown do
          File.unlink(@other_path)
        end
        
        should "convert @settings to_yaml" do
          assert_match(/key\:.+12345/, File.open(@other_path) {|f| f.read })
        end
        
        should "write yaml to path" do
          assert File.readable?(@other_path)
        end
        
      end
            
      context "get" do
        setup do
          Settings.path = File.join(purse_path, 'settings.yml')
        end
        
        context "if @settings are loaded" do
          setup do
            Settings.expects(:loaded?).returns(true)
            Settings.settings = {:path => purse_path}
          end
          
          should "retrieve setting by key" do
            assert_equal purse_path, Settings.get('path')
            assert_equal purse_path, Settings.get(:path)
          end
        end
        
        context "if settings are not loaded" do
          setup do
            YAML.expects(:load_file)
            Settings.expects(:load).at_most_once
            Settings.expects(:loaded?).at_least_once.returns(:false)
            Settings.get('repository')
          end
          
          should "load settings from path" do
            assert Settings.settings
          end
          
          should "retrieve setting by key" do
            assert_equal 'github.com', Settings.get('repository')
            assert_equal 'github.com', Settings.get(:repository)
          end
        end
      end
     
      context "set" do
        setup do
          @other_path = File.join(purse_path, 'other_settings.yml')
          Settings.path = @other_path
        end
        
        teardown do
          File.unlink(@other_path)
        end
        
        should "put setting with key into @settings" do
          Settings.set('key', 'value')
          assert_equal 'value', Settings.settings['key']
        end
        
        should "save settings to path" do
          Settings.expects(:save).at_most_once
          Settings.set('key', 'value')
        end
      end
    end
  end
end
