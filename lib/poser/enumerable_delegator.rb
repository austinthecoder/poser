require 'poser/delegator'

module Poser
  class EnumerableMimicker < Mimicker

    def each
      __getobj__.each { |object| yield present(object) }
    end

  end
end