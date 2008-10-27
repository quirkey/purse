module Purse
  class Note
    attr_reader :path, :name, :encrypted, :options 
    attr_accessor :data
    
    def initialize(path, name, data, options = {})
      Purse.check_for_parameter('path', path)
      Purse.check_for_parameter('name', name)
      @path = path
      @name = name
      @options = options
      if options[:encrypted]
        @encrypted = data
      else
        @data = data
      end
    end
    
    def self.load(path, name, options = {})
      note = Note.new(path, name, nil)
      raise MissingFile, "Tried to load #{note.file_path} but it does not exist" unless File.readable?(note.file_path)
      encrypted_data = File.read(note.file_path)
      Note.new(path, name, encrypted_data, options.merge(:encrypted => true))
    end

    def save(password)
      Purse.check_for_parameter('password', password)
      encrypt(password)
      File.open(file_path, 'w') {|f| f << @encrypted }
      self
    end

    def encrypt(password)
      Purse.check_for_parameter('password', password)
      blowfish = Crypt::Blowfish.new(password)
      @encrypted = blowfish.encrypt_string(@data)
    end

    def decrypt(password)
      Purse.check_for_parameter('password', password)
      blowfish = Crypt::Blowfish.new(password)
      @data = blowfish.decrypt_string(@encrypted)
    end
    
    def encrypted?
      @encrypted && (!@data || @data.blank?)
    end
    
    def delete
      File.unlink(file_path)
    end
    
    def file_path
      File.join(path, file_name)
    end
    
    def file_name
      "#{name}.note"
    end
    
  end
end