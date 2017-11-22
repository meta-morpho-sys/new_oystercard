require 'oystercard'

describe Oystercard do
  it 'is issued with initial balance of £0' do
    expect(subject.balance).to eq 0
  end
end