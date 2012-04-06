require 'poser/util'

module Poser
  module Presentable

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      attr_writer :presenter_class

      def presenter_class
        @presenter_class ||= Util.first_available_class(
          "#{self}::Presenter",
          "#{self}Presenter",
          "Poser::Presenter"
        )
      end
    end

    def to_presenter(context)
      self.class.presenter_class.new self, context
    end

  end
end