require "spec_helper"

describe Codacy::Reporter do
  describe 'start' do
    before do
      allow(SimpleCov).to receive(:formatter=)
      allow(SimpleCov).to receive(:start)
    end

    subject(:start) {described_class.start }

    it 'sets Codacy::Formatter' do
      start

      expect(SimpleCov).to have_received(:formatter=).with(Codacy::Formatter)
    end

    it 'calls SimpleCov start' do
      start

      expect(SimpleCov).to have_received(:start).with(nil)
    end

    context 'when profile param given' do
      subject(:start) { described_class.start('rails') }

      it 'calls SimpleCov start with given profile' do
        start

        expect(SimpleCov).to have_received(:start).with('rails')
      end
    end
  end
end
