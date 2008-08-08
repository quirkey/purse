module Purse
  class Pocket
    attr_reader :path
    
    def initialize(path)
      Purse.check_for_parameter('path', path)
      @path = File.expand_path(path)
    end
    
    def init(root_path, pocket_name)
      
    end
    
    def find(name)
      Purse.check_for_parameter('name', name)
      note = notes.find {|note| note.name == name }
      note ? note : raise(Purse::MissingFile, "Could note find the note named #{note}")
    end
    
    def notes
      @notes ||= load_notes
    end
    
    def notes_paths
      Dir[File.join(@path, '*.note')]
    end
    
    def load_notes
      notes_paths.collect {|note_path| Note.load(File.dirname(note_path), File.basename(note_path, '.note'))}
    end
    
    def re_encrypt(password)
      Purse.check_for_parameter('password', password)
      notes.collect {|n| n.save(password) }
    end
    
    def push
      
    end
    
    def pull
      
    end
    
  end
end