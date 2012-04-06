require 'poser/presenter'

module Poser
  module Context

    def present(object, context = self)
      Presenter.present object, context
    end

  end
end