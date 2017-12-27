# Handles information about fares and penalties and calculates fares.
class Billing
  PENALTY_FARE = 6.0
  DEFAULT_FARE = 3.0
  COST_PER_ZONE = 1.1

  def initialize
    @fare = DEFAULT_FARE
  end

  def calculate_fare(journey)
    return PENALTY_FARE unless journey.complete?
    src_zone = journey.entry_station.zone.to_i
    dst_zone = journey.exit_station.zone.to_i
    @fare = lookup_zone_crossing_fare(src_zone, dst_zone)
  end

  private

  def lookup_zone_crossing_fare(src_zone, dst_zone)
    (dst_zone - src_zone).abs * COST_PER_ZONE + DEFAULT_FARE
    # TODO: Compare with ROUTE[1][2], i.e. ROUTE[src_zone][dst_zone]
  end
end
