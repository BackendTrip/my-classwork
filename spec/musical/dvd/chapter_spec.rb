
# coding: utf-8
require 'spec_helper'
require 'musical'

describe Musical::DVD::Chapter do
  describe '#initialize' do
    subject { described_class.new(vob_path, options) }

    context 'when vob path is not given' do
      let(:vob_path) { nil }
      let(:options) { {} }
      it 'raises an ArgumentError' do
        expect{ subject }.to raise_error(ArgumentError)
      end
    end

    context 'when vob path is given' do
      let(:vob_path) { '/path/to/foo.vob' }
      let(:options) { { chapter_number: 3 } }
      it 'returns an instance of Chapter' do
        expect(subject).to be_a(described_class)
        expect(subject.chapter_number).to eq(3)
      end
    end
  end