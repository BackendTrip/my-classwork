# coding: utf-8
require 'spec_helper'
require 'musical'

describe Musical::Configuration do
  describe '#build' do
    subject { described_class.build(op