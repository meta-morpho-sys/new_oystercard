require 'oystercard'

describe Oystercard do
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  context 'by default' do
    it 'has a balance of £0.' do
      expect(subject.balance).to eq 0
    end
    it 'is not in use' do
      expect(subject.in_journey?).to eq false
    end
    it 'has an empty list of journeys' do
      expect(subject.journeys).to be_empty
    end
  end

  context 'when managing the credit' do
    it 'increases balance' do
      expect { subject.top_up 50 }.to change { subject.balance }.by 50
    end

    it 'has a balance limit' do
      max_balance = described_class::MAX_BALANCE
      subject.top_up max_balance
      expect do
        subject.top_up 1
      end.to raise_exception described_class::BALANCE_OVERFLOW_MSG
    end
    it 'has a minimum required amount' do
      subject.top_up 2
      expect do
        subject.touch_in('Euston')
      end.to raise_exception described_class::INSUFFICIENT_FUNDS_MSG
    end
  end

  describe '#touch_out' do
    it 'causes it not to be in use' do
      expect(subject.touch_out(exit_station)).not_to be_in_journey
    end

    it 'forgets the name of the entry station' do
      subject.touch_out exit_station
      expect(subject.entry_station).to eq nil
    end
  end

  context 'When topped up' do
    before(:each) do
      subject.top_up 10
      subject.touch_in entry_station
    end

    context 'touched in' do
      it 'it is in use' do
        expect(subject.in_journey?).to eq true
      end

      it 'remembers the entry station' do
        expect(subject.entry_station).to eq entry_station
      end
    end

    context 'touched out' do
      it 'decreases the balance of the card' do
        min_charge = described_class::MIN_REQUIRED_AMOUNT
        p subject
        expect do
          subject.touch_out exit_station
        end.to change { subject.balance }.by(-min_charge)
      end

      it 'remembers exit station' do
        subject.touch_out exit_station
        expect(subject.exit_station).to eq exit_station
      end
    end
  end
end
