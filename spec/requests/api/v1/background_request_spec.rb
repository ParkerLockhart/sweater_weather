require 'rails_helper'

RSpec.describe 'Background Endpoint' do
  describe 'GET background' do
    before(:each) do
      VCR.insert_cassette('san_antonio_photo')
      get '/api/v1/backgrounds?location=san%20antonio,tx'
    end
    after(:each) do
      VCR.eject_cassette('san_antonio_photo')
    end

    let!(:background) { JSON.parse(response.body, symbolize_names: true) }

    it 'returns successful' do
      expect(response).to be_successful
    end

    it 'returns correct data' do
      expect(background).to have_key(:data)
      expect(background[:data]).to be_a(Hash)

      expect(background[:data]).to have_key(:id)
      expect(background[:data][:id]).to eq(nil)

      expect(background[:data]).to have_key(:type)
      expect(background[:data][:type]).to eq('image')

      expect(background[:data]).to have_key(:attributes)
      expect(background[:data][:attributes]).to be_a(Hash)

      expect(background[:data][:attributes]).to have_key(:location)
      expect(background[:data][:attributes][:location]).to be_a(String)

      expect(background[:data][:attributes]).to have_key(:image_url)
      expect(background[:data][:attributes][:image_url]).to be_a(String)

      expect(background[:data][:attributes]).to have_key(:credit)
      expect(background[:data][:attributes][:credit]).to be_a(Hash)

      expect(background[:data][:attributes][:credit]).to have_key(:source)
      expect(background[:data][:attributes][:credit][:source]).to eq('https://unsplash.com')

      expect(background[:data][:attributes][:credit]).to have_key(:author)
      expect(background[:data][:attributes][:credit][:author]).to be_a(String)
    end
  end
end
