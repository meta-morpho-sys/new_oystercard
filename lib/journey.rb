#  it is responsible for starting a journey, finishing a journey,
# calculating the fare of a journey, and returning whether or not
# the journey is complete.
class Journey
  def initialize
    @started = false
  end

  def start
    @started = true
  end

  def started?
    @started
  end
end
