require_relative 'journey'
# Main class that takes account of journeys, fares and penalties.
class Oystercard
  MIN_REQUIRED_AMOUNT = 3
  MAX_BALANCE = 90
  # Constants assigned error messages.
  BALANCE_OVERFLOW_MSG = "Max balance of £#{MAX_BALANCE} exceeded.".freeze
  INSUFFICIENT_FUNDS_MSG = "Minimum required is £#{MIN_REQUIRED_AMOUNT}.".freeze
  attr_reader :balance, :journey, :journeys

  def initialize
    @balance = 0
    @journey = nil
    @journeys = []
  end

  def entry_station
    journey.entry_station if journey
  end

  def exit_station
    journeys[-1].exit_station if journeys[-1]
  end

  def top_up(sum)
    raise BALANCE_OVERFLOW_MSG if balance + sum > MAX_BALANCE
    @balance += sum
    self
  end

  def touch_in(station)
    raise INSUFFICIENT_FUNDS_MSG if balance < MIN_REQUIRED_AMOUNT
    @journey = Journey.new station
    self
  end

  def touch_out(station)
    deduct(MIN_REQUIRED_AMOUNT)
    @journey.exit_station = station
    @journeys << journey
    @journey = nil
    self
  end

  def in_journey?
    !journey.nil?
  end

  private

  def deduct(sum)
    @balance -= sum
  end
end
