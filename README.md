# Poser

A minimal implementation of the presenter pattern.

[![Build Status](https://secure.travis-ci.org/austinthecoder/poser.png?branch=master)](http://travis-ci.org/austinthecoder/poser)

## Installation

Add this line to your application's Gemfile:

    gem 'poser'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install poser

## Usage

```
class Battle
end

class Warrior < Poser::Presenter
  def fighting?
    true
  end
end

class Person
  def initialize(name)
    @name = name
  end

  attr_reader :name

  def to_presenter(context)
    Warrior.new(self, context) if context.is_a?(Battle)
  end

  def fighting?
    false
  end
end

person = Person.new 'Austin'
person.name       # 'Austin'
person.fighting?  # false

battle = Battle.new

warrior = person.to_presenter battle
warrior.name       # 'Austin'
warrior.fighting?  # true
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
