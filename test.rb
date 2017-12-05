filename = 'stations_and_zones.dat'
# a = File.readlines(filename)

File.open(filename, 'r').each_line do |line|
  p line
end
