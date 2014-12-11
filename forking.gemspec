# -*- encoding: utf-8 -*-

require File.expand_path('../lib/forking/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "forking"
  gem.version       = Forking::VERSION
  gem.summary       = %q{A tool for forking on github}
  gem.description   = %q{Allow a rapid fork}
  gem.license       = "MIT"
  gem.authors       = ["Franky W."]
  gem.email         = "frankywahl@users.noreply.github.com"
  gem.homepage      = "https://rubygems.org/gems/forking"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rdoc'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rubygems-tasks'
end
