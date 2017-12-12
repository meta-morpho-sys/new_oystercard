require 'oystercard'

def complete_journey
  subject.touch_in entry_station
  subject.touch_out exit_station
end

describe Oystercard do
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) { Journey.new(entry_station, exit_station) }

  context 'by default' do
    it 'has a balance of £0' do
      expect(subject.balance).to eq 0
    end
    it 'is not in use' do
      expect(subject.in_journey?).to eq false
    end
    it 'has an empty list of journeys' do
      expect(subject.journeys).to eq []
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

  context 'while travelling' do
    before(:each) do
      subject.top_up 10
      subject.touch_in entry_station
    end

    context 'when in use' do
      context 'and touched in' do
        it 'is in journey' do
          expect(subject.in_journey?).to eq true
        end
      end

      context 'and touched out' do
        it 'causes it not to be in use' do
          expect(subject.touch_out(exit_station)).not_to be_in_journey
        end

        it 'decreases the balance of the card' do
          min_charge = described_class::MIN_REQUIRED_AMOUNT
          expect do
            subject.touch_out exit_station
          end.to change { subject.balance }.by(-min_charge)
        end
      end
    end
  end

  context 'after one or more journeys' do
    before(:each) do
      subject.top_up 10
      complete_journey
    end
    it 'stores a journey' do
      expect(subject.journeys).to eq [journey]
    end
    it 'stores a number of journeys' do
      complete_journey
      expect(subject.journeys).to eq [journey, journey]
    end
  end
end
