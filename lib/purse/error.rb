module Purse
  class Error < RuntimeError; end 
  
  class MissingParameter < Error; end;
  class MissingFile      < Error; end
  
end