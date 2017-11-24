require 'oystercard'

describe Oystercard do
  let(:entry_station) { double :station }

  context 'When initialized' do
    it 'is issued with initial balance of £0.' do
      expect(subject.balance).to eq 0
    end
    it 'it is not in use' do
      expect(subject.in_journey?).to eq false
    end
  end
  context 'When managing credit' do
    describe '#top_up' do
      it 'increases balance of the card.' do
        expect { subject.top_up 50 }.to change { subject.balance }.by 50
      end
      it 'has a limit balance.' do
        max_balance = described_class::MAX_BALANCE
        subject.top_up max_balance
        message = "Max balance of £#{max_balance} exceeded."
        expect { subject.top_up 1 }.to raise_exception message
      end
    end
  end
  context 'When used for travelling' do
    describe '#touch in' do
      xit 'once touched in, it is in use.' do
        subject.top_up 10
        expect(subject.touch_in).to be_in_journey
      end
      xit 'has a minimum required amount.' do
        subject.top_up 2
        min_amount = described_class::MIN_REQUIRED_AMOUNT
        message = "Minimum required is £#{min_amount}."
        expect { subject.touch_in }.to raise_exception message
      end
      it 'remembers the entry station' do
        allow(entry_station).to receive(:name) { 'Piccadilly' }
        subject.top_up 10
        subject.touch_in 'Piccadilly'
        expect(subject.station).to eq 'Piccadilly'
      end
    end
    describe '#touch_out' do
      it 'once touched out, it is not in use' do
        expect(subject.touch_out).not_to be_in_journey
      end
      it 'decreases the balance of the card.' do
        subject.top_up 2
        min_charge = described_class::MIN_REQUIRED_AMOUNT
        expect do
          subject.touch_out
        end.to change { subject.balance }.by(-min_charge)
      end
    end
  end
end
