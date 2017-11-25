require 'oystercard'

describe Oystercard do
  let(:entry_station) { double :entry_station }

  context 'by default' do
    it 'has balance of £0.' do
      expect(subject.balance).to eq 0
    end
    it 'is not in use' do
      expect(subject.in_journey?).to eq false
    end
  end

  describe '#top_up' do
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
  end

  describe '#touch in' do
    it 'has a minimum required amount' do
      subject.top_up 2
      expect do
        subject.touch_in('Euston')
      end.to raise_exception described_class::INSUFFICIENT_FUNDS_MSG
    end

    it 'remembers the entry station' do
      subject.top_up(10).touch_in 'Piccadilly'
      expect(subject.entry_station).to eq 'Piccadilly'
    end
  end

  describe '#touch_out' do
    it 'once touched out, it is not in use' do
      expect(subject.touch_out).not_to be_in_journey
    end

    context 'with a top-up' do
      before(:each) { subject.top_up 10 }

      it 'once touched in, it is in use' do
        subject.touch_in('Euston Square')
        expect(subject.in_journey?).to eq true
      end

      it 'decreases the balance of the card' do
        min_charge = described_class::MIN_REQUIRED_AMOUNT
        expect do
          subject.touch_out
        end.to change { subject.balance }.by(-min_charge)
      end

      it 'forgets the name of the entry station' do
        subject.touch_in('Piccadilly')
        subject.touch_out
        expect(subject.entry_station).to eq nil
      end
    end
  end
end
