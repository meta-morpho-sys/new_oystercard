require_relative 'billing'

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
    @billing = Billing.new
  end

  # Creates a journey, adds it to the journeys array and returns the current log
  def start_journey(station)
    raise 'Already in journey' if in_journey?
    @journey = @journey_class.new(station)
    self
  end

  # Finishes a journey, updates the array of journeys and returns the fare
  # calculated by journey.
  def finish_journey(station)
    @journey.exit_station = station
    @journeys << @journey
    fare = @billing.calculate_fare(@journey)
    @journey = nil
    fare
  end

  private

  def in_journey?
    @journey.nil? ? false : true
  end
end
