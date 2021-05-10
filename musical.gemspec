# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'musical/version'

Gem::Specification.new do |spec|
  spec.name          = "musical"
  spec.version       = Musical::VERSION
  spec.authors       = ["