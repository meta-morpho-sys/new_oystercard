require 'journey'

describe Journey do
  let(:journey) { Journey.new(en_station, ex_station) }
  let(:en_station) { double :station, zone: 1 }
  let(:ex_station) { double :station, zone: 2 }

  it 'has entry and exit stations' do
    expect(journey.entry_station).to eq en_station
    expect(journey.exit_station).to eq ex_station
  end

  it 'has a penalty fare by default' do
    expect(journey.penalty).to eq described_class::PENALTY_FARE
  end

  context 'knows a journey is not complete' do
    it 'when exit station is not registered' do
      journey = Journey.new en_station
      expect(journey.complete?).to be false
    end

    it 'and charges a penalty fare' do
      journey = Journey.new en_station
      expect(journey.calculate_fare).to eq described_class::PENALTY_FARE
    end

    it 'when entry station is not registered' do
      journey = Journey.new nil
      expect(journey.complete?).to be false
    end

    it 'and charges a penalty fare' do
      journey = Journey.new nil
      expect(journey.calculate_fare).to eq described_class::PENALTY_FARE
    end
  end

  it 'computes the fare between zone 1 and zone 2' do
    expect(journey.calculate_fare).to be_within(0.01).of(1.1)
  end
end
