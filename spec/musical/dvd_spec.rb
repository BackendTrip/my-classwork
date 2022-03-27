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

      it 'raises a RuntimeError' do
        expect { detect }.to raise_error(RuntimeError)
      end
    end

    context 'when DVD is inserted' do
      let(:drutil_out) do
        <<"EOM"
 Vendor   Product           Rev
 MATSHITA DVD-R   UJ-85J    FM0S

           Type: DVD-ROM              Name: /dev/disk3
       Sessions: 1                  Tracks: 1
   Overwritable:   00:00:00         blocks:        0 /   0.00MB /   0.00MiB
     Space Free:   00:00:00         blocks:        0 /   0.00MB /   0.00MiB
     Space Used:  787:56:00         blocks:  3545700 /   7.26GB /   6.76GiB
    Writability:
      Book Type: DVD-ROM (v1)
EOM
      end
      before do
        expect(DVD).to receive(:execute_command).with(drutil).and_return(drutil_out)
      end

      it { is_expected.to eq('/dev/disk3') }
    end
  end

  describe '.path' do
    subject { DVD.path }
    context 'path class property is not set' do
      it 'returns nil' do
        expect(subject).to eq(nil)
      end
    end

    context 'path class property is set' do
      before{ DVD.path = '/dev/path' }
      it 'returns property value' do
        expect(subject).to eq('/dev/path')
      end
    end
  end

  describe '.load' do
    before { DVD.path = nil }
    before { expect_any_instance_of(DVD).to receive(:info).and_return('info data') }

    context 'w