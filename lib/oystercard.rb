require_relative 'journey'
require_relative 'station'

# Main class that takes account of journeys, fares and penalties.
class Oystercard
  MIN_REQUIRED_AMOUNT = Journey::DEFAULT_FARE
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
    @journey.exit_station = station
    deduct(@journey.calculate_fare)
    finish_journey
    self
  end

  def in_journey?
    !journey.nil?
  end

  private

  def deduct(sum)
    @balance -= sum
  end

  def finish_journey
    @journeys << journey
    @journey = nil
  end
end

card = Oystercard.new
entry = Station.new :'Piccadilly Circus'
exit = Station.new :Clapton

card.top_up 4
card.touch_in entry
p card.touch_out exit
p card.balance
