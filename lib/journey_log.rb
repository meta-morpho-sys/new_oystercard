# JourneyLog class is responsible for starting a journey, ending a journey and
# returning a list of journeys.
class JourneyLog
  attr_reader :journey_class

  def journeys
    @journeys.dup
  end

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @journeys = []
  end

  # Creates a journey, adds it to the journeys array and returns the current log
  def start_journey(station)
    @journey = @journey_class.new(station)
    self
  end

  # Finishes a journey, updates the array of journeys and returns the fare
  # calculated by journey.
  def finish_journey(station)
    @journey.exit_station = station
    @journeys << @journey
    @journey.calculate_fare
  end
end

# require_relative 'journey'
# jl = JourneyLog.new(Journey)
# jl.start_journey('Blah')
# p jl.journeys
# p jl.finish_journey('Bloh')
