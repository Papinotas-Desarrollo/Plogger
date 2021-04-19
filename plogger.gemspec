# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'plogger/version'

Gem::Specification.new do |spec|
  spec.name          = "plogger"
  spec.version       = Plogger::VERSION
  spec.authors       = ["Daniel Merrill"]
  spec.email         = ["daniel@papinotas.com"]

  spec.summary       = "Phoenix Logging Interface."
  spec.description   = "Provides a standard way to generate logs in the application."
  spec.homepage      = "https://github.com/Papinotas-Desarrollo/Plogger"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
