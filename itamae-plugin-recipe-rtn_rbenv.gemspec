# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'itamae/plugin/recipe/rtn_rbenv/version'

Gem::Specification.new do |spec|
  spec.name          = "itamae-plugin-recipe-rtn_rbenv"
  spec.version       = Itamae::Plugin::Recipe::RtnRbenv::VERSION
  spec.authors       = ["Ru/MuckRu"]
  spec.email         = ["ru_shalm@hazimu.com"]
  spec.summary       = %q{Itamae Recipe 'rbenv'}
  spec.description   = %q{Itamae Recipe 'rbenv'}
  spec.homepage      = "https://github.com/rutan/itamae-plugin-recipe-rtn_rbenv"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "itamae", "~> 1.0"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "serverspec", "~> 2.0"
end

