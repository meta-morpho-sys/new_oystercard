require 'station'
#  It is responsible for storing entry and exit stations,
# calculating the fare of a journey, and returning whether or not
# the journey is complete.
class Journey
  PENALTY_FARE = 6
  DEFAULT_FARE = PENALTY_FARE # TODO: revisit this
  ROUTE_1_2 = 2.90
  attr_reader :entry_station, :fare
  attr_accessor :exit_station
  def initialize(entry_station, exit_station = nil)
    # If the exit station is defaulted to nil,
    # then it does not have to be given by the caller. Not until it is needed.
    @entry_station = entry_station
    @exit_station = exit_station
    @fare = DEFAULT_FARE
  end

  def ==(other)
    entry_station == other.entry_station &&
      exit_station == other.exit_station
  end

  def calculate_fare(entry = entry_station, exit = exit_station)
    src_zone = entry.zone
    dst_zone = exit.zone
    lookup_zone_crossing_fare(src_zone, dst_zone)
  end

  def complete?
    entry_station && exit_station ? true : false
  end

  private

  # TODO: finish the logic for route method. Find a way to avoid if statements.
  def lookup_zone_crossing_fare(src_zone, dst_zone)
    ROUTE_1_2 if src_zone == 1 && dst_zone == 2
    # TODO: Compare with ROUTE[1][2], i.e. ROUTE[src_zone][dst_zone]
  end
end

# TODO: Read about DeMorgan's Laws
