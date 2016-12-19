module Booking
  class BasePresenter
    def initialize(object, template)
      @object = object
      @template = template
    end

    #Defines a method using the object's name for other presenters to refer to directly
    def self.presents(name)
      define_method(name) do
        @object
      end
    end

    #Anything that the presenter doesn't know about will be sent to the template
    #Can call helper method without "template.helper_method"
    def method_missing(*args, &block)
      @template.send(*args, &block)
    end
  end
end
