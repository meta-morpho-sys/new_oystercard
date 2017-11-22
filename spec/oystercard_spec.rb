require 'oystercard'

describe Oystercard do
  it 'is issued with initial balance of £0' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it 'increases balance of the card' do
      expect { subject.top_up 50 }.to change { subject.balance }.by 50
    end
    it 'has a limit balance' do
      max_balance = described_class::MAX_BALANCE
      subject.top_up max_balance
      message = "Max balance of £ #{max_balance} exceeded"
      expect { subject.top_up 1 }.to raise_exception message
    end
  end
end
