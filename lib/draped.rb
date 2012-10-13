module Draped
  extend ActiveSupport::Concern

  class NoDefaultDecoratorError < StandardError
  end

  module ClassMethods
    def decorator
      @decorator ||= begin
        "#{name}Decorator".constantize
      rescue NameError
        raise NoDefaultDecoratorError, "There is no default decorator for class #{name}."
      end
    end

    def decorate(instances = nil)
      decorator.decorate(instances || scoped)
    end
  end

  def redecorate
    @decorated = self.class.decorator.new(self)
  end

  def decorate
    @decorated ||= self.class.decorator.new(self)
  end
end