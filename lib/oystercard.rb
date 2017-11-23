# Main class that takes account of journeys, fares and penalties.
class Oystercard
  MIN_REQUIRED_AMOUNT = 3
  MAX_BALANCE = 90
  attr_reader :balance
  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(sum)
    message = "Max balance of £#{MAX_BALANCE} exceeded."
    raise message if balance + sum > MAX_BALANCE
    @balance += sum
  end

  def deduct(sum)
    message = "No availability! Remaining balance is £#{balance}."
    raise message if balance - sum < MIN_REQUIRED_AMOUNT
    @balance -= sum
  end

  def touch_in
    @in_journey = true
    self
  end

  def touch_out
    @in_journey = false
    self
  end

  def in_journey?
    @in_journey
  end
end
