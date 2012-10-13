module Draped
  extend ActiveSupport::Concern

  class NoDefaultDecoratorError < StandardError
  end

  included do
    cattr_accessor :default_decorator
  end

  module ClassMethods
    def decorator
      @decorator ||= respond_to?(:default_decorator) && default_decorator
      @decorator ||= begin
        "#{name}Decorator".constantize
      rescue NameError => e
        raise NoDefaultDecoratorError,
          "There is no default decorator for class #{name}. Set it in default_decorator class method."
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