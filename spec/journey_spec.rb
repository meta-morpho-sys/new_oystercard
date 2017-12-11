require 'journey'

describe Journey do
  let(:en_station) { double :station, zone: 1 }
  let(:ex_station) { double :station, zone: 2 }


  it 'has entry and exit stations' do
    journey = Journey.new en_station, ex_station
    expect(journey.start_end_stations)
      .to eq(
        start: en_station,
        end: ex_station
      )
  end
end
