# Main class that takes account of journeys, fares and penalties.
class Oystercard
  attr_reader :balance
  def initialize
    @balance = 0
  end
end