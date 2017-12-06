# Acts like a station and interacts with the Oystercard class,
# learns dynamically its zones by referencing a file containing stations names.
# and zones.
class Station
  attr_reader :name, :zone

  def self.get_zone(name, filename = 'stations_and_zones.dat')
    File.foreach(filename) do |line|
      st_name, zone = line.chomp.split(',')
      return zone if st_name.to_sym == name
    end
  end

  def initialize(name)
    @name = name
    @zone = self.class.get_zone @name
  end
end
