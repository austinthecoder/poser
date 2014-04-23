require 'delegate'

module Poser
  class Mimicker < SimpleDelegator

    class << self
      def mimickers
        @mimickers ||= []
      end

      def mimic(object, context)
        if object.respond_to?(:mimicked?) && object.mimicked?
          object
        else
          mimicked_object = Mimicked.new object, context
          exhibits.inject mimicked_object do |mimicked_object, mimicker_class|
            mimicker_class.mimic_if_applicable mimicked_object, context
          end
        end
      end

      def mimic_if_applicable(object, context)
        applicable_to?(object) ? new(object, context) : object
      end

      def applicable_to?(object)
      end
    end

    def initialize(object, context)
      @context = context
      super object
    end

    attr_reader :context

    def mimic(object)
      Mimicker.mimic object, context
    end

    def mimicked?
      true
    end

    def mimicker_chain
      [self.class] + (defined?(super) ? super : [])
    end

    def inspect_mimickers
      mimicker_chain.map(&:to_s).join ':'
    end

    def inspect
      "#{inspect_mimickers}(#{__getobj__.inspect})"
    end

    # def id
    #   __getobj__.id
    # end

    # def ==(other)
    #   other.is_a?(self.class) && context == other.context && __getobj__ == other.__getobj__
    # end

  private

    # The terminator for the mimic chain, and a marker that an object
    # has been through the mimic process
    class Mimicked < Mimicker
      def mimicker_chain
        []
      end

      def to_model
        __getobj__
      end
    end

  end
end