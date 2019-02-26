require 'airport'

describe Airport do 

  subject(:airport) { described_class.new(20) }
  let(:plane) {  double :plane }
  
  describe '#land' do 

    it 'instructs a plane to land' do
      expect(airport).to respond_to(:land).with(1).argument
    end

    it 'can store a plane' do 
      airport.land(plane)
      expect(airport.planes[0]).to equal plane 
    end 

    context 'when full' do
      it 'raises an error' do 
        20.times do 
          airport.land(plane)
        end
        expect { airport.land(plane) }.to raise_error 'Cannot land plane: airport full'
      end 
    end
  end
  
  describe '#take_off' do 

    it 'instructs a plane to take_off' do 
      expect(airport).to respond_to(:take_off).with(1).argument
    end

    it 'can release a plane' do
      airport.land(plane)
      airport.take_off(plane) 
      expect(airport.planes).to be_empty
    end 
  end
end