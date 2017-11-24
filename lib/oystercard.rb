# Main class that takes account of journeys, fares and penalties.
class Oystercard
  MIN_REQUIRED_AMOUNT = 3
  MAX_BALANCE = 90
  attr_reader :balance, :station

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(sum)
    message = "Max balance of £#{MAX_BALANCE} exceeded."
    raise message if balance + sum > MAX_BALANCE
    @balance += sum
    self
  end

  def touch_in(station)
    message = "Minimum required is £#{MIN_REQUIRED_AMOUNT}."
    raise message if balance < MIN_REQUIRED_AMOUNT
    @station = station
    @in_journey = true
    self
  end

  def touch_out
    deduct(MIN_REQUIRED_AMOUNT)
    @station = nil
    @in_journey = false
    self
  end

  def in_journey?
    @in_journey
  end

  private

  def deduct(sum)
    @balance -= sum
  end
end
