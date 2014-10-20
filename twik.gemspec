# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'twik/version'

Gem::Specification.new do |spec|
  spec.name          = "twik"
  spec.version       = Twik::VERSION
  spec.authors       = ["Guillaume Dott"]
  spec.email         = ["guillaume+github@dott.fr"]
  spec.summary       = %q{Twik Password Generator}
  spec.description   = %q{Twik is an gem that makes it easier to generate secure and different passwords for each website.}
  spec.homepage      = "https://github.com/gdott9/twik-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
