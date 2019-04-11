describe 'User Stories' do 

  let(:airport) { Airport.new(weather_reporter, 20) }
  let(:plane) {Plane.new }
  let(:weather_reporter) { WeatherReporter.new }

  context 'when not stormy' do
    before do 
      allow(weather_reporter).to receive(:stormy?).and_return false
    end
    # As an air traffic controller 
    # So I can get passengers to a destination 
    # I want to instruct a plane to land at an airport
    it 'instructs a plane to land at an airport' do 
      expect { airport.land(plane) }.not_to raise_error
    end

    # As an air traffic controller 
    # So I can get passengers on the way to their destination 
    # I want to instruct a plane to take off from an airport and confirm that it is no longer in the airport

    it 'instructs a plane to take off from an airport' do 
      airport.land(plane)
      expect { airport.take_off(plane) }.not_to raise_error
    end

    it 'confirms that a plane is not longer in an airport' do 
      airport.land(plane)
      expect(airport.planes[0]).to equal plane
      airport.take_off(plane)
      expect(airport.planes).to be_empty
    end 

    # As an air traffic controller
    # To ensure safety
    # I want to planes to only take off from the airport they are at
    it 'takes off planes only from the airport they are at' do 
      airport_2 = Airport.new(weather_reporter, 20)
      airport_2.land(plane)
      expect { airport.take_off(plane) }.to raise_error 'Cannot take off plane: plane not at this airport' 
    end

    # As the system designer
    # So that the software can be used for many different airports
    # I would like a default airport capacity that can be overridden as appropriate
    it 'airports have a default capacity' do 
      default_airport = Airport.new(weather_reporter)
      Airport::DEFAULT_CAPACITY.times { default_airport.land(plane) }
      expect { default_airport.land(plane) }.to raise_error 'Cannot land plane: airport full'
    end

    # As an air traffic controller
    # So the system is consistent and correctly reports plane status and location
    # I want to ensure a flying plane cannot take off and cannot be in an airport
    it 'flying planes cannot take off' do 
      airport.land(plane)
      flying_plane = airport.take_off(plane)
      expect { flying_plane.take_off }.to raise_error 'Plane can not take off: plane already flying'
    end

    it 'fying planes cannot be in an airport' do 
      airport.land(plane)
      flying_plane = airport.take_off(plane)
      expect { flying_plane.airport }.to raise_error 'Plane can not be in an airport: plane already flying'
    end

    context 'when airport is full' do
    # As an air traffic controller 
    # To ensure safety 
    # I want to prevent landing when the airport is full 
      it 'prevents landing' do 
        20.times do 
          airport.land(plane)
        end
        expect { airport.land(plane) }.to raise_error 'Cannot land plane: airport full'
      end 
    end
  end

  context 'when stormy' do 
    before do 
      allow(weather_reporter).to receive(:stormy?).and_return true
    end
    # As an air traffic controller 
    # To ensure safety 
    # I want to prevent landing when weather is stormy 
    it 'prevents landing' do 
      expect { airport.land(plane) }.to raise_error 'Cannot land plane: weather is stormy'
    end 
    # As an air traffic controller 
    # To ensure safety 
    # I want to prevent takeoff when weather is stormy
    it 'prevents take off' do 
      expect { airport.take_off(plane) }.to raise_error 'Cannot take off plane: weather is stormy'
    end

  end

end
