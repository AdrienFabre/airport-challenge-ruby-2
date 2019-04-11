describe 'User Stories' do 

  let(:airport) { Airport.new(20) }
  let(:plane) {Plane.new }

  context 'when not stormy' do
    before do 
      allow(airport).to receive(:stormy?).and_return false
    end
    # As an air traffic controller 
    # So I can get passengers to a destination 
    # I want to instruct a plane to land at an airport
    it 'instructs a plane to land at an airport' do 
      expect { airport.land(plane) }.not_to raise_error
    end

  #   As an air traffic controller 
  #   So I can get passengers on the way to their destination 
  #   I want to instruct a plane to take off from an airport and confirm that it is no longer in the airport

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

  #   As an air traffic controller 
  #   To ensure safety 
  #   I want to prevent landing when the airport is full 

    context 'when airport is full' do
      it 'prevents landing' do 
        allow(airport).to receive(:stormy?).and_return false
        20.times do 
          airport.land(plane)
        end
        expect { airport.land(plane) }.to raise_error 'Cannot land plane: airport full'
      end 
    end
  end

  # As an air traffic controller 
  # To ensure safety 
  # I want to prevent landing when weather is stormy 
  
  # As an air traffic controller 
  # To ensure safety 
  # I want to prevent takeoff when weather is stormy 
  
  context 'when weather is stormy' do 
    before do 
      allow(airport).to receive(:stormy?).and_return true
    end

    it 'prevents landing' do 
      expect { airport.land(plane) }.to raise_error 'Cannot land plane: weater is stormy'
    end 

  end

end
