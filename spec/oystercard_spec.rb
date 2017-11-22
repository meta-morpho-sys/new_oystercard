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
      subject.top_up 90
      message = 'Maximum balance exceeded'
      expect { subject.top_up 1 }.to raise_exception message
    end
  end
end
