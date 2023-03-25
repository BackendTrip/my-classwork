
# coding: utf-8
require 'spec_helper'
require 'musical'

describe Musical::Util do
  class DummyClass
    include Musical::Util
  end
  let!(:klass) { DummyClass.new }

  describe '#check_env' do
    subject(:check_env) { klass.check_env }

    context 'when app is not installed' do
      before do
        expect(klass).to receive(:installed?).and_return(false)
      end

      it 'raises a RuntimeError' do
        expect { check_env }.to raise_error(RuntimeError)
      end
    end

    context 'when app is installed' do