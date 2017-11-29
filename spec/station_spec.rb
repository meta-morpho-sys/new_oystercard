require 'station'

describe Station do
  it 'is created with a name' do
    station = Station.new :Piccadilly
    expect(station.name).to eq :Piccadilly
  end
end
