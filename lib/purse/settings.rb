module Purse
  class Settings

    class << self
      def default_path
        File.join(File.expand_path('~'), '.purse', 'settings.yml')
      end

      def path
        @path ||= default_path
      end

      def path=(new_path)
        raise MissingParameter unless new_path.is_a?(String)
        @path = new_path
        @loaded = false
      end

      def load
        save unless File.readable?(path)
        @settings = YAML.load_file(path)
        @loaded = true
      end

      def loaded?
        @loaded ||= false
      end

      def save
        FileUtils.mkdir_p(File.dirname(path))
        File.open(path, 'w') {|f| f << YAML::dump(settings) }
      end

      def get(key)
        load unless loaded?
        settings[key.to_s]
      end

      def set(key, value, should_save = true)
        settings[key.to_s] = value
        save if should_save
      end

      def settings
        @settings ||= {}
      end
      
      def settings=(new_settings)
        return unless new_settings.is_a?(Hash)
        new_settings.each do |k, v|
          set(k, v, false)
        end
        save
      end
    end 
  end
end