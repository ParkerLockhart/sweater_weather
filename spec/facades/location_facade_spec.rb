require 'rails_helper'

RSpec.describe LocationFacade do
  describe 'lat_lng' do
    it 'returns location object' do
      VCR.use_cassette('san_antonio') do
        location = LocationFacade.lat_lng('San Antonio,TX')

        expect(location).to be_instance_of(Location)
      end 
    end
  end
end
