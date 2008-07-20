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
        FileUtils.mkdir_p(File.dirname(new_path))
        @path = new_path
      end

      def load
        @settings = YAML.load_file(path)
        @loaded = true
      rescue => e
        raise MissingFile, "#{e}"
      end

      def loaded?
        @loaded ||= false
      end

      def save
        File.open(path, 'w') {|f| f << YAML::dump(settings) }
      end

      def get(key)
        load unless loaded?
        settings[key.to_s]
      end

      def set(key, value)
        settings[key.to_s] = value
        save
      end

      def settings
        @settings ||= {}
      end
      
      def settings=(new_settings)
        return unless new_settings.is_a?(Hash)
        @settings = new_settings
      end
    end 
  end
end