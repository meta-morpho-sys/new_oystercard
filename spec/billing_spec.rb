require 'billing'

describe Billing do
  let(:billing) { Billing.new }
  let(:en_station) { double :station, zone: 1 }
  let(:ex_station) { double :station, zone: 2 }
  let(:journey) do
    double :journey, entry_station: en_station, exit_station: ex_station
  end

  it 'computes the fare between zone 1 and zone 2' do
    allow(journey).to receive(:complete?).and_return true
    expect(billing.calculate_fare(journey)).to be_within(0.01).of(4.1)
  end

  it 'charges a penalty fare if journey is  ot complete' do
    allow(journey).to receive(:complete?).and_return false
    expect(billing.calculate_fare(journey)).to eq Billing::PENALTY_FARE
  end
end
