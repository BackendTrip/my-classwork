# coding: utf-8
require 'spec_helper'
require 'musical'

include Musical

describe DVD do
  describe '.detect' do
    subject(:detect) { DVD.detect }
    let(:drutil) { 'drutil status' }

    context 'when DVD drive is not found' do
      before do
        expect(DVD).to receive(:execute_command).with(dr