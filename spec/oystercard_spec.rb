require 'oystercard'

def complete_journey
  subject.touch_in entry_station
  subject.touch_out exit_station
end

describe Oystercard do
  let(:entry_station) { double :station, zone: 1 }
  let(:exit_station) { double :station, zone: 2 }
  let(:j) { Journey.new entry_station, exit_station }
  let(:journey) { double :journey, entry_station: entry_station }
  let(:journey_log_1) { double :journey_log, finish_journey: exit_station }

  context 'by default' do
    it 'has a balance of £0' do
      expect(subject.balance).to eq 0
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
      max_balance = Oystercard::MAX_BALANCE
      subject.top_up max_balance
      expect do
        subject.top_up 1
      end.to raise_exception Oystercard::BALANCE_OVERFLOW_MSG
    end

    it 'has a minimum required amount' do
      subject.top_up 2
      expect do
        subject.touch_in('Euston')
      end.to raise_exception Oystercard::INSUFFICIENT_FUNDS_MSG
    end
  end

  context 'while travelling' do
    before(:each) do
      subject.top_up 10
      subject.touch_in entry_station
    end

    context 'when in use' do
      context 'and touched out' do
        it 'decreases the balance of the card by fare' do
          expect do
            subject.touch_out exit_station
          end.to change { subject.balance }.by(a_value_within(0.01).of(-4.1))
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
      expect(subject.journeys).to eq [j]
    end
    it 'stores a number of journeys' do
      complete_journey
      expect(subject.journeys).to eq [j, j]
    end
  end
end
