# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'paxx/version'

Gem::Specification.new do |spec|
  spec.name          = "paxx"
  spec.version       = Paxx::VERSION
  spec.authors       = ["leffen"]
  spec.email         = ["leffen@gmail.com"]

  spec.summary       = %q{Simple gem with date_parser}
  spec.description   = %q{Parsing input dates according to norwegian format and custom}
  spec.homepage      = "http://github.com/leffen/paxx"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'babosa'
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
