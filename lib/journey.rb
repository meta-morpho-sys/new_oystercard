#  It is responsible for storing entry and exit stations,
# calculating the fare of a journey, and returning whether or not
# the journey is complete.
class Journey
  PENALTY_FARE = 6
  attr_reader :entry_station, :fare
  attr_accessor :exit_station
  def initialize(entry_station, exit_station = nil)
    # If the exit station is defaulted to nil,
    # then it does not have to be given by the caller. Not until it is needed.
    @entry_station = entry_station
    @exit_station = exit_station
    @fare = PENALTY_FARE
  end

  def ==(other)
    entry_station == other.entry_station &&
      exit_station == other.exit_station
  end

  # def compute_fare
  #   @fare
  # end

  def complete?
    !entry_station.nil? && !exit_station.nil?
  end
end
