require 'oystercard'

describe Oystercard do
  it 'is issued with initial balance of £0.' do
    expect(subject.balance).to eq 0
  end

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
  describe '#deduct' do
    it 'decreases the balance of the card.' do
      subject.top_up 70
      expect { subject.deduct 7 }.to change { subject.balance }.by(-7)
    end
    it 'has a minimum required amount.' do
      subject.top_up 2
      message = "No available funds! Remaining balance is £#{subject.balance}."
      expect { subject.deduct 3 }.to raise_exception message
    end
  end
  describe '#touch in/#touch out support' do
    it 'once touched in, it is in use.' do
      expect(subject.touch_in).to be_in_journey
    end
    it 'once touched out, it is not in use' do
      expect(subject.touch_out).not_to be_in_journey
    end
  end
end
