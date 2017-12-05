require 'station'

describe Station do
  it 'is created with a name' do
    station = Station.new :Piccadilly
    expect(station.name).to eq :Piccadilly
  end

  it 'knows its zone' do
    station = Station.new :Clapton
    expect(station.zone).to eq '2'
  end

  it 'knows its zone' do
    station = Station.new :'Piccadilly Circus'
    expect(station.zone).to eq '1'
  end
  it 'knows its zone' do
    station = Station.new :'Euston Square'
    expect(station.zone).to eq '1'
  end
end
