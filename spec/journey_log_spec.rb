require 'journey_log'

describe JourneyLog do
  let(:journey) { double :journey, calculate_fare: 6 }
  let(:station) { double :station }
  let(:journey_class) { double :journey_class, new: journey }
  subject { JourneyLog.new(journey_class) }

  describe '#start_journey' do
    it 'starts a journey' do
      expect(journey_class).to receive(:new).with(station)
      subject.start_journey(station)
    end

    # xit 'raises an exception if already in journey' do
    #   allow(journey_class).to receive(:new).and_return journey
    #   subject.start_journey(station)
    #   expect { subject.start_journey(station) }.to raise_exception 'Already in journey'
    # end
  end

  describe '#finish_journey' do
    it 'finishes a journey' do
      allow(journey).to receive(:exit_station=).and_return station
      subject.start_journey(station)
      subject.finish_journey(station)
      expect(subject.journeys).to include journey
    end

    it 'returns the calculated fare'
  end
end
