# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'musical/version'

Gem::Specification.new do |spec|
  spec.name          = "musical"
  spec.version       = Musical::VERSION
  spec.authors       = ["ryo katsuma"]
  spec.email         = ["katsuma@gmail.com"]
  spec.description   = %q{musical is a simple tool for your favorite DVD. You can rip vob file by DVD chapter, convert it to wav file and add it to your iTunes library.}
  spec.summary       = %q{A simple rip, encode and iTunes library tool for your favorite DVD}
  spec.homepage      = "http://github.com/katsuma/musical"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/})