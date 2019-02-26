describe 'User Stories' do 

  # As an air traffic controller 
  # So I can get passengers to a destination 
  # I want to instruct a plane to land at an airport
  it 'instructs a plane to land at an airport' do 
    airport = Airport.new
    plane = Plane.new
    expect { airport.land(plane) }.not_to raise_error
  end

#   As an air traffic controller 
#   So I can get passengers on the way to their destination 
#   I want to instruct a plane to take off from an airport and confirm that it is no longer in the airport

  it 'instructs a plane to take off from an airport' do 
    airport = Airport.new
    plane = Plane.new
    airport.land(plane)
    expect { airport.take_off(plane) }.not_to raise_error
  end

  it 'confirms that a plane is not longer in an airport' do 
    airport = Airport.new
    plane = Plane.new
    airport.land(plane)
    expect(airport.hangar[0]).to equal plane
    airport.take_off(plane)
    expect(airport.hangar).to be_empty
  end 

end
