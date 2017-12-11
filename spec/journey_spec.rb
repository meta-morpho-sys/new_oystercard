require 'journey'

describe Journey do
  let(:station) { double :station, zone: 1 }
  let(:station) { double :station, zone: 2 }

  it 'starts with an entry station' do
    journey = Journey.new :station, :station
    expect(journey.entry_station).to be :station
  end
end
