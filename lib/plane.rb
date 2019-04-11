class Plane 

  def initialize
    @flying = true
  end

  def take_off
    raise "Plane can not take off: plane already flying" if @flying
    @flying = true
  end

  def land(airport)
    raise 'Plane can not land: plane already landed' unless @flying
    @flying = false
    @airport = airport
  end

  def airport
    raise 'Plane can not be in an airport: plane already flying' if @flying
    @airport
  end
end 