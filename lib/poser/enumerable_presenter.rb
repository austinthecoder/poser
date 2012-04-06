require 'poser/presenter'

module Poser
  class EnumerablePresenter < Presenter

    def each
      __getobj__.each { |object| yield present(object) }
    end

  end
end