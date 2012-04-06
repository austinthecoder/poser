# -*- encoding: utf-8 -*-
require File.expand_path('../lib/poser/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Austin Schneider"]
  gem.email         = ["austinthecoder@gmail.com"]
  gem.description   = 'A minimal implementation of the presenter pattern.'
  gem.summary       = 'A minimal implementation of the presenter pattern.'
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "poser"
  gem.require_paths = ["lib"]
  gem.version       = Poser::VERSION

  gem.add_development_dependency "rspec", ">= 2.9.0"
end
