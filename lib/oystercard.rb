# Main class that takes account of journeys, fares and penalties.
class Oystercard
  MIN_REQUIRED_AMOUNT = 3
  MAX_BALANCE = 90
  attr_reader :balance
  def initialize
    @balance = 0
  end

  def top_up(sum)
    message = "Max balance of £#{MAX_BALANCE} exceeded."
    raise message if balance + sum > MAX_BALANCE
    @balance += sum
  end

  def deduct(sum)
    message = "No available funds! Remaining balance is £#{balance}."
    raise message if balance - sum < MIN_REQUIRED_AMOUNT
    @balance -= sum
  end
end
