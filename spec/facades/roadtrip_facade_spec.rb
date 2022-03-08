require 'rails_helper'

RSpec.describe RoadtripFacade do
  describe 'roadtrip' do
    it 'returns roadtrip object' do
      VCR.use_cassette('roadtrip') do
        VCR.use_cassette('denver_weather') do
          roadtrip = RoadtripFacade.roadtrip('San Antonio, TX', 'Denver, CO')

          expect(roadtrip).to be_instance_of(Roadtrip)
        end 
      end
    end
  end
end
