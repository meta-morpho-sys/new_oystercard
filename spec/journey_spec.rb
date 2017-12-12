require 'journey'

describe Journey do
  let(:en_station) { double :station, zone: 1 }
  let(:ex_station) { double :station, zone: 2 }

  it 'has entry and exit stations' do
    journey = Journey.new en_station, ex_station
    expect(journey.entry_station).to eq en_station
    expect(journey.exit_station).to eq ex_station
  end

  it 'has a penalty fare by default' do
    journey = Journey.new en_station, ex_station
    expect(journey.fare).to eq described_class::PENALTY_FARE
  end

  context 'knows a journey is not complete' do
    it 'when exit station is not registered' do
      journey = Journey.new en_station
      expect(journey.complete?).to be false
    end
    it 'when entry station is not registered' do
      journey = Journey.new nil, ex_station
      expect(journey.complete?).to be false
    end
  end

end
