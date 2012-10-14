class ActiveRecord::Base
  class << self
    alias :h :human_attribute_name
  end
end