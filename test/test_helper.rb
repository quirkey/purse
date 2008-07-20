require 'test/unit'
require 'rubygems'
require 'shoulda'
require 'mocha'

require File.dirname(__FILE__) + '/../lib/purse'

class Test::Unit::TestCase
  
  include Purse
  
  def purse_path
    File.join(File.dirname(__FILE__), 'test_purse_data')
  end
  
  def assert_all(collection)
    collection.each do |one|
      assert yield(one), "#{one} is not true"
    end
  end

  def assert_any(collection, &block)
    has = collection.any? do |one|
      yield(one)
    end
    assert has
  end

  def assert_ordered(array_of_ordered_items, message = nil, &block)
    raise "Parameter must be an Array" unless array_of_ordered_items.is_a?(Array)
    message ||= "Items were not in the correct order"
    i = 0
    # puts array_of_ordered_items.length
    while i < (array_of_ordered_items.length - 1)
      # puts "j"
      a, b = array_of_ordered_items[i], array_of_ordered_items[i+1]
      comparison = yield(a,b)
      # raise "#{comparison}"
      assert(comparison, message + " - #{a}, #{b}")
      i += 1
    end
  end
  
  def assert_set_of(klass, set)
    assert set.respond_to?(:each), "#{set} is not a set (does not include Enumerable)"
    assert_all(set) {|a| a.is_a?(klass) }
  end
  
  def self.should_require(setting_name,&block) 
    should "require parameter #{setting_name}" do
      assert_raise(MissingParameter) { yield }
    end
  end
end