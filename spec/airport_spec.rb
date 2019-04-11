require 'airport'

describe Airport do 

  subject(:airport) { described_class.new(20, weather_reporter) }
  let(:plane) {  double :plane }  
  let(:weather_reporter) { double :weather_reporter }

  
  describe '#land' do 
    context 'when not stormy' do 
      before do 
        allow(weather_reporter).to receive(:stormy?).and_return false
      end

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

    context 'when stormy' do 
      it 'raises an error' do 
        allow(airport).to receive(:stormy?).and_return true
        expect { airport.land(plane) }.to raise_error 'Cannot land plane: weater is stormy'
      end
    end
  end
  
  describe '#take_off' do 

    it 'instructs a plane to take_off' do 
      expect(airport).to respond_to(:take_off).with(1).argument
    end

    it 'can release a plane' do
      allow(weather_reporter).to receive(:stormy?).and_return false
      airport.land(plane)
      airport.take_off(plane) 
      expect(airport.planes).to be_empty
    end
    
    context 'when stormy' do 
      it 'raises an error' do 
        allow(weather_reporter).to receive(:stormy?).and_return true
        expect { airport.take_off(plane) }.to raise_error 'Cannot take off plane: weater is stormy'
      end
    end

  end
  
end