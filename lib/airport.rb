require 'weather_reporter'

class Airport

  attr_reader :planes

  def initialize(capacity, weather_reporter)
    @capacity = capacity
    @weather_reporter = weather_reporter
    @planes = []
  end

  def land(plane)
    raise 'Cannot land plane: airport full' if full?
    raise 'Cannot land plane: weater is stormy' if stormy?
    @planes << plane
  end

  def take_off(plane)
    raise 'Cannot take off plane: weater is stormy' if stormy?
    @planes.delete(plane)
  end

  private

  def full?
    @planes.length >= @capacity
  end

  def stormy?
    @weather_reporter.stormy?
  end 
end