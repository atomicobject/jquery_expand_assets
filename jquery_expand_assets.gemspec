# -*- encoding: utf-8 -*-
require File.expand_path('../lib/jquery_expand_assets/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Matt Fletcher"]
  gem.email         = ["fletcher@atomicobject.com"]
  gem.description   = %q{Sprockets processor for jquery.expand templates}
  gem.summary       = %q{Sprockets processor for jquery.expand templates}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "jquery_expand_assets"
  gem.require_paths = ["lib"]
  gem.version       = JqueryExpandAssets::VERSION

  gem.add_runtime_dependency 'tilt', '~>1'
end
