# coding: utf-8
require 'spec_helper'
require 'musical'

describe Musical::DVD::Wav do
  describe '#delete!' do
    subject { wav.delete! }
    let!(:wav) do
      Fi