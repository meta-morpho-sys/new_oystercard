# acts like a station and interacts with the Oystercard class
class Station
  attr_reader :name, :zone

  def initialize(name)
    @name = name
    get_name_and_zone
  end

  def get_name_and_zone(filename = 'stations_and_zones.dat')
    File.open(filename, 'r') do |file|
      file.readlines.each do |line|
        st_name, zone = line.chomp.split(',')
        @zone = zone if st_name.to_sym == @name
      end
    end
  end
end
