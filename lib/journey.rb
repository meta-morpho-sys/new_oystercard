#  It is responsible for starting a journey, finishing a journey,
# calculating the fare of a journey, and returning whether or not
# the journey is complete.
class Journey
  attr_reader :entry_station, :exit_station
  def initialize(entry_station, exit_station)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def ==(other)
    entry_station == other.entry_station &&
      exit_station == other.exit_station
  end
end
