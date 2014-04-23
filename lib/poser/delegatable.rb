require 'poser/util'

module Poser
  module Delegatable

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      attr_writer :delegator_class

      def delegator_class
        @delegator_class ||= Util.first_available_class(
          "#{self}::Mimicker",
          "#{self}Mimicker",
          "Poser::Mimicker"
        )
      end
    end

    def to_delegator(context)
      self.class.delegator_class.new self, context
    end

  end
end