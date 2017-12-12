require 'journey'

describe Journey do
  let(:en_station) { double :station, zone: 1 }
  let(:ex_station) { double :station, zone: 2 }

  it 'has entry and exit stations' do
    journey = Journey.new en_station, ex_station
    expect(journey.entry_station).to eq en_station
    expect(journey.exit_station).to eq ex_station
  end
end
