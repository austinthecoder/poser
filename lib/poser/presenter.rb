require 'delegate'

module Poser
  class Presenter < SimpleDelegator

    class << self
      def present(object, context)
        if object.respond_to?(:presented?) && object.presented?
          object
        elsif object.respond_to? :to_presenter
          object.to_presenter context
        else
          new object, context
        end
      end
    end

    def initialize(presentee, context)
      super presentee
      @context = context
    end

    attr_reader :context

    def id
      __getobj__.id
    end

    def present(object)
      self.class.present object, context
    end

    def presented?
      true
    end

    def ==(other)
      other.is_a?(self.class) && context == other.context && __getobj__ == other.__getobj__
    end

  end
end