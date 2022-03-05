require 'rails_helper'

RSpec.describe LocationService do
  describe 'class methods' do
    describe 'city_to_latlng' do
      before(:each) do
        VCR.insert_cassette('san_antonio')
      end
      after(:each) do
        VCR.eject_cassette('san_antonio')
      end

      let!(:location) {LocationService.city_to_latlng("San Antonio,TX")}

      it 'returns response hash' do
        expect(location).to be_a(Hash)
      end

      it 'response hash contains results array' do
        expect(location[:results]).to be_an(Array)
      end

      it 'results array contains hash' do
        expect(location[:results].first).to be_a(Hash)
      end

      it 'results hash contains locations array' do
        expect(location[:results].first[:locations]).to be_an(Array)
      end

      it 'locations array contains hash' do
        expect(location[:results].first[:locations].first).to be_a(Hash)
      end

      it 'locations hash contains lat/lng data' do
        expect(location[:results].first[:locations].first[:latLng]).to have_key(:lat)
        expect(location[:results].first[:locations].first[:latLng][:lat]).to be_a(Float)

        expect(location[:results].first[:locations].first[:latLng]).to have_key(:lng)
        expect(location[:results].first[:locations].first[:latLng][:lng]).to be_a(Float)
      end
    end
  end
end
