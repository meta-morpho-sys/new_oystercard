# Main class that takes account of journeys, fares and penalties.
class Oystercard
  MIN_REQUIRED_AMOUNT = 3
  MAX_BALANCE = 90
  # Constants assigned error messages.
  BALANCE_OVERFLOW_MSG = "Max balance of £#{MAX_BALANCE} exceeded.".freeze
  INSUFFICIENT_FUNDS_MSG = "Minimum required is £#{MIN_REQUIRED_AMOUNT}.".freeze
  attr_reader :balance, :entry_station, :exit_station

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(sum)
    raise BALANCE_OVERFLOW_MSG if balance + sum > MAX_BALANCE
    @balance += sum
    self
  end

  def touch_in(station)
    raise INSUFFICIENT_FUNDS_MSG if balance < MIN_REQUIRED_AMOUNT
    @entry_station = station
    self
  end

  def touch_out(station)
    deduct(MIN_REQUIRED_AMOUNT)
    @entry_station = nil
    @exit_station = station
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
