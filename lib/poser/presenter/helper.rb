require 'poser/presenter'

module Poser
  class Presenter
    module Helper

      def present(object, context = self)
        Presenter.present object, context
      end

    end
  end
end