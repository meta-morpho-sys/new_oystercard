require 'journey_log'

describe JourneyLog do
  let(:en_station) { double :station, zone: 1 }
  let(:ex_station) { double :station, zone: 2 }
  let(:journey) do
    double :journey, entry_station: en_station, exit_station: ex_station
  end
  let(:journey_class) { double :journey_class, new: journey }
  subject { JourneyLog.new(journey_class) }

  describe '#start_journey' do
    it 'starts a journey' do
      expect(journey_class).to receive(:new).with(en_station)
      subject.start_journey(en_station)
    end

    it 'raises an exception if already in journey' do
      allow(journey_class).to receive(:new).and_return journey
      subject.start_journey(en_station)
      expect { subject.start_journey(en_station) }
        .to raise_exception 'Already in journey'
    end
  end

  describe '#finish_journey' do
    before(:each) do
      allow(journey).to receive(:exit_station=)
      allow(journey).to receive(:complete?) { true }
      subject.start_journey(en_station)
    end

    it 'has a journey' do
      subject.finish_journey(ex_station)
      expect(subject.journeys).to include journey
    end

    it 'returns the calculated fare' do
      fare = subject.finish_journey(ex_station)
      expect(fare).to eq 4.1
    end
  end
end
