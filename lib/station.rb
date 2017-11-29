# acts like a station and interacts with the Oystercard class
class Station
  attr_reader :name

  def initialize(name)
    @name = name
  end
end
