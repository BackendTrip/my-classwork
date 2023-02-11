
# coding: utf-8
require 'spec_helper'
require 'musical'

describe Musical do
  describe '#setup', fakefs: true do
    subject(:setup) { Musical.setup }
    before { expect(Musical).to receive(:check_env).and_return(true) }

    context 'when argument `info` is given' do
      before { stub_const('ARGV', ['--info']) }
      it { expect(setup.info).to be_truthy }
    end

    context 'when argument `ignore-convert-sound` is given' do
      before { stub_const('ARGV', ['--ignore-convert-sound']) }
      it { expect(setup.ignore_convert_sound).to be_truthy }
    end

    context 'when argument `ignore-use-itunes` is given' do
      before { stub_const('ARGV', ['--ignore-use-itunes']) }
      it { expect(setup.ignore_use_itunes).to be_truthy }
    end
