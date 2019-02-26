require 'airport'

describe Airport do 

  subject(:airport) { described_class.new }
  let(:plane) { Plane.new }
  

  it 'instructs a plane to land' do
    expect(airport).to respond_to(:land).with(1).argument
  end

  it 'instructs a plane to take_off' do 
    expect(airport).to respond_to(:take_off).with(1).argument
  end

  it 'can store a plane' do 
    airport.land(plane)
    expect(airport.hangar[0]).to equal plane 
  end 

  it 'can release a plane' do
    airport.land(plane)
    airport.take_off(plane) 
    expect(airport.hangar).to be_empty
  end 

end