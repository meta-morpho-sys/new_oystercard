require 'station'

describe Station do
  it 'is created with a name' do
    station = Station.new :Piccadilly, 1
    expect(station.name).to eq :Piccadilly
  end

  it 'knows its zone' do
    station = Station.new :Clapton, 2
    expect(station.zone).to eq 2
  end
end
