class Plane 

  def take_off
    raise "Plane can not take off: plane already flying"
  end

  def airport
    raise 'Plane can not be in an airport: plane already flying'
  end
end 