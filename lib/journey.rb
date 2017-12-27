require_relative 'station'

#  It is responsible for storing entry and exit stations,
# and returning whether or not the journey is complete.
class Journey
  attr_reader :entry_station
  attr_accessor :exit_station

  def initialize(entry_station, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def ==(other)
    entry_station == other.entry_station &&
      exit_station == other.exit_station
  end

  def complete?
    entry_station && exit_station ? true : false
  end
end
