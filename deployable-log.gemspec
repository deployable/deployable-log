# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'deployable/log/version'

Gem::Specification.new do |spec|
  spec.name          = "deployable-log"
  spec.version       = Deployable::Log::VERSION
  spec.authors       = ["deployable"]
  spec.email         = ["matt@deployable.co"]
  spec.summary       = %q{Log singleton}
  spec.description   = %q{Log singleton}
  spec.homepage      = "http://deployable.co"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "pry-byebug", "~> 2.0"
end
