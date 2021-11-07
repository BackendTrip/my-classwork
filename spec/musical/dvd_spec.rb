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
        expect(DVD).to receive(:execute_command).with(drutil).and_return('')
      end

      it 'raises a RuntimeError' do
        expect { detect }.to raise_error(RuntimeError)
      end
    end

    context 'when DVD is not inserted' do
      let(:drutil_out) do
        <<"EOM"
Vendor   Product           Rev
MATSHITA DVD-R   UJ-85J    FM0S

Type: No Media Inserted
EOM
      end
      before { expect(DVD).to receive(:execute_command).with(drutil).and_return(drutil_out) }

      it 'raises a RuntimeError' d