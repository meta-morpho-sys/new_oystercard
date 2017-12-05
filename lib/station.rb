# acts like a station and interacts with the Oystercard class
class Station
  attr_reader :name, :zone

  def initialize(name)
    @name = name
    get_name_and_zone
  end

  def get_name_and_zone(filename = 'stations_and_zones.dat')
    file = File.open(filename, 'r')
    file.readlines.each do |line|
      name_st, zone = line.chomp.split(',')
      @zone = zone if name_st.to_sym == @name
    end
    file.close
  end
end
