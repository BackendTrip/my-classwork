# coding: utf-8

require 'bundler'
require 'fakefs/spec_helpers'
require 'simplecov'
require 'coveralls'

Bundler.setup(:default, :development)

RSpec.configure do |config|
  confi