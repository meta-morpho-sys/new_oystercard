require 'station'

describe Station do
  context 'class method' do
    it 'class method looks up zones' do
      expect(Station.get_zone(:Clapton)).to eq '2'
    end
    it 'raises an exception if does not find a match' do
      expect { Station.get_zone(:Bank) }
        .to raise_exception 'No matching station.'
    end
  end

  it 'is created with a correct name' do
    expect { Station.new :Piccadilly }
      .to raise_exception 'No matching station.'
  end

  it 'knows its zone1' do
    station = Station.new :'Piccadilly Circus'
    expect(station.zone).to eq '1'
  end

  it 'knows its zone2' do
    station = Station.new :Clapton
    expect(station.zone).to eq '2'
  end
end
