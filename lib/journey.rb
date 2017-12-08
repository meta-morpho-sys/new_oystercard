#  It is responsible for starting a journey, finishing a journey,
# calculating the fare of a journey, and returning whether or not
# the journey is complete.
class Journey
  attr_reader :entry_station
  def initialize(entry_station)
    @entry_station = entry_station
  end
end
