require 'airport'

describe Airport do 

  subject(:airport) { described_class.new(20) }
  let(:plane) { Plane.new }
  

  it 'instructs a plane to land' do
    expect(airport).to respond_to(:land).with(1).argument
  end

  it 'instructs a plane to take_off' do 
    expect(airport).to respond_to(:take_off).with(1).argument
  end

  it 'can store a plane' do 
    plane = double :plane
    airport.land(plane)
    expect(airport.planes[0]).to equal plane 
  end 

  it 'can release a plane' do
    plane = double :plane
    airport.land(plane)
    airport.take_off(plane) 
    expect(airport.planes).to be_empty
  end 

  it 'does not allow landing when at capacity' do 
    plane = double :plane
    20.times do 
      airport.land(plane)
    end
    expect { airport.land(plane) }.to raise_error 'Cannot land plane: airport full'
  end 

end