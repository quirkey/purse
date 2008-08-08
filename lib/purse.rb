$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'git'
require 'crypt/blowfish'
require 'yaml'

require 'purse/error'
require 'purse/settings'
require 'purse/pocket'
require 'purse/note'
require 'purse/cli'