require 'poser/delegator'

module Poser
  module Context

    def present(object, context = self)
      Mimicker.present object, context
    end

  end
end