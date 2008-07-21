module Purse
  class Error < RuntimeError; end 
  
  class MissingParameter < Error; end;
  class MissingFile      < Error; end
  
  def self.check_for_parameter(name, param)
    raise MissingParameter, "You must set a #{name}" if param.nil? || param.strip == ''
  end
end