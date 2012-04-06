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
          determine_presenter_class(object).new object, context
        end
      end

      def presents(name)
        alias_method name, :__getobj__
      end

    private

      def determine_presenter_class(object)
        object.class::Presenter
      rescue NameError
        if object.is_a?(Enumerable) || (defined?(ActiveRecord) && object.is_a?(ActiveRecord::Relation))
          EnumerablePresenter
        else
          self
        end
      end
    end

    def initialize(presentee, context)
      super presentee
      @context = context
    end

    attr_reader :context

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