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

    context 'when options are not given' do
      subject { DVD.load }

      context 'and if path is set' do
        before { DVD.path = '/dev/some/path' }
        it 'does not call DVD.detect' do
          expect(DVD).not_to receive(:detect)
          subject
        end
      end

      context 'and if DVD path is not set' do
        it 'sets path by DVD.detect' do
          expect(DVD).to receive(:detect).and_return('/dev/some/path')
          subject
          expect(DVD.path).to eq('/dev/some/path')
        end
      end
    end

    context 'when options are given' do
      subject { DVD.load(options) }
      context 'and if option does not have `forcibly` key' do
        let(:options) { { path: '/dev/path', title: 'some title' } }

        it 'sets path by given option' do
          subject
          expect(DVD.path).to eq('/dev/path')
        end

        it 'sets title by given option' do
          subject
          expect(DVD.instance.title).to eq('some title')
        end
      end

      context 'and if option has `forcibly` key' do
        let(:options) { { forcibly: true } }
        before { DVD.path = '/dev/some/path' }

        it 'calls DVD.detect forcibly even if path is already set' do
          expect(DVD).to receive(:detect).and_return('/dev/some/path')
          subject
        end
      end
    end

    context 'when block is given' do
      subject { DVD.load { |dvd| dvd.artist = 'some artist' }  }
      before { expect(DVD).to receive(:detect).and_return('/dev/path') }
      it 'calls proc object' do
        subject
        expect(DVD.instance.artist).to eq('some artist')
      end
    end
  end

  describe '#info' do
    subject { dvd.info }
    let(:dvd) { DVD.instance }

    context 'when DVD.path is not set' do
      before { DVD.path = nil }
      it 'raises an RuntimeError' do
        expect { subject }.to raise_error(RuntimeError)
      end
    end

    context 'when DVD.path is set' do
      before { DVD.path = '/dev/path' }
      let(:info_da