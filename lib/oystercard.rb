# Main class that takes account of journeys, fares and penalties.
class Oystercard
  MAX_BALANCE = 90
  attr_reader :balance
  def initialize
    @balance = 0
  end

  def top_up(sum)
    raise 'Maximum balance exceeded' if balance >= MAX_BALANCE
    @balance += sum
  end
end
