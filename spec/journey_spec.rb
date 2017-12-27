require 'journey'

describe Journey do
  let(:journey) { Journey.new(en_station, ex_station) }
  let(:en_station) { double :station, zone: 1 }
  let(:ex_station) { double :station, zone: 2 }

  it 'has entry and exit stations' do
    expect(journey.entry_station).to eq en_station
    expect(journey.exit_station).to eq ex_station
  end

  context 'knows it is not complete' do
    it 'when exit station is not registered' do
      journey = Journey.new en_station
      expect(journey.complete?).to be false
    end

    it 'when entry station is not registered' do
      journey = Journey.new nil
      expect(journey.complete?).to be false
    end
  end
end
