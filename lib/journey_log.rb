# JourneyLog class is responsible for starting a journey, ending a journey and
# returning a list of journeys.
class JourneyLog
  def initialize(journey_class:)
    @journey_class = journey_class
  end

  def start_journey(station)
    @journey_class.new(entry_station: station)
  end
end
