require_relative 'journey_log'
require_relative 'journey'

# Main class that takes account of journeys, fares and penalties.
class Oystercard
  MIN_REQUIRED_AMOUNT = Journey::DEFAULT_FARE
  MAX_BALANCE = 90
  # Constants assigned error messages.
  BALANCE_OVERFLOW_MSG = "Max balance of £#{MAX_BALANCE} exceeded.".freeze
  INSUFFICIENT_FUNDS_MSG = "Minimum required is £#{MIN_REQUIRED_AMOUNT}.".freeze
  attr_reader :balance, :journey_log

  def initialize
    @balance = 0
    @journey_log = JourneyLog.new
  end

  # Thi is a convenience accessor. THis method goes into JourneyLog and returns
  # a list of journeys
  def journeys
    @journey_log.journeys
  end

  def top_up(sum)
    raise BALANCE_OVERFLOW_MSG if balance + sum > MAX_BALANCE
    @balance += sum
    self
  end

  def touch_in(station)
    raise INSUFFICIENT_FUNDS_MSG if balance < MIN_REQUIRED_AMOUNT
    journey_log.start_journey(station)
    self
  end

  def touch_out(station)
    fare = journey_log.finish_journey(station)
    deduct(fare)
    self
  end

  private

  def deduct(sum)
    @balance -= sum
  end
end
