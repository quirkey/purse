module Purse
  class Pocket
    attr_reader :path
    
    def initialize(path)
      Purse.check_for_parameter('path', path)
      @path = File.expand_path(path)
    end
    
    def init
      FileUtils.mkdir_p(@path) unless File.readable?(@path)
      git
    end
    
    def find(name)
      Purse.check_for_parameter('name', name)
      note = notes.find {|note| note.name == name }
      note ? note : raise(Purse::MissingFile, "Could note find the note named #{note}")
    end
    
    def edit(name)
      Purse.check_for_parameter('name', name)
      begin
        note = find(name)
      rescue Purse::MissingFile
        note = Note.new(path, name, nil)
      end
      yield(note)
      @notes = load_notes
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
    
    def commit
      git.add('.')
      return if git.status.changed.empty?
      git.commit_all("Changes via Purse #{Time.now}")
    end
    
    def remote
      git.remotes.first
    end
    
    def set_remote(remote_url)
      git.add_remote('origin', remote_url)
    end
    
    def push
      git.push('origin')
    end
    
    def pull
      git.pull('origin')
    end
    
    protected
    def git
      @git ||= Git.init(@path)
    end
  end
end