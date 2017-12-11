#  It is responsible for starting a journey, finishing a journey,
# calculating the fare of a journey, and returning whether or not
# the journey is complete.
class Journey
  attr_reader :entry_station, :exit_station, :start_end_stations
  def initialize(entry_station, exit_station)
    @entry_station = entry_station
    @exit_station = exit_station
    record_journey(entry_station, exit_station)
  end

  def ==(other)
    entry_station == other.entry_station &&
      exit_station == other.exit_station
  end

  def record_journey(entry, exit)
    @start_end_stations = Hash[:start, entry, :end, exit]
    self
  end
end
