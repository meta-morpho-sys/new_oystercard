# Main class that takes account of journeys, fares and penalties.
class Oystercard
  MIN_REQUIRED_AMOUNT = 3
  MAX_BALANCE = 90
  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
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
    @entry_station = station
    self
  end

  def touch_out
    deduct(MIN_REQUIRED_AMOUNT)
    @entry_station = nil
    self
  end

  def in_journey?
    !@entry_station.nil?
  end

  private

  def deduct(sum)
    @balance -= sum
  end
end
