require 'rails_helper'

RSpec.describe 'Roadtrip Endpoint' do
  describe 'GET roadtrip' do
    before(:each) do
      VCR.insert_cassette('roadtrip')
      VCR.insert_cassette('denver_weather')
      user_params = { email: "jeff@email.com", password: "password123", password_confirmation: "password123" }
      post '/api/v1/users', params: user_params
      @user = JSON.parse(response.body, symbolize_names: true)
      roadtrip_params = { origin: 'San Antonio, TX', destination: 'Denver, CO', api_key: @user[:data][:attributes][:api_key] }
      get '/api/v1/roadtrip', params: roadtrip_params
    end

    after(:each) do
      VCR.eject_cassette('roadtrip')
      VCR.eject_cassette('denver_weather')
    end

    let!(:roadtrip) { JSON.parse(response.body, symbolize_names: true) }

    it 'returns successful' do
      expect(response).to be_successful
    end

    it 'returns response hash with data key' do
      expect(roadtrip).to be_a(Hash)
      expect(roadtrip).to have_key(:data)
      expect(roadtrip[:data]).to be_a(Hash)
    end

    it 'returns correct data' do
      expect(roadtrip[:data]).to have_key(:id)
      expect(roadtrip[:data][:id]).to eq(nil)

      expect(roadtrip[:data]).to have_key(:type)
      expect(roadtrip[:data][:type]).to eq("roadtrip")

      expect(roadtrip[:data]).to have_key(:attributes)
      expect(roadtrip[:data][:attributes]).to be_a(Hash)

      expect(roadtrip[:data][:attributes]).to have_key(:start_city)
      expect(roadtrip[:data][:attributes][:start_city]).to be_a(String)

      expect(roadtrip[:data][:attributes]).to have_key(:end_city)
      expect(roadtrip[:data][:attributes][:end_city]).to be_a(String)

      expect(roadtrip[:data][:attributes]).to have_key(:travel_time)
      expect(roadtrip[:data][:attributes][:travel_time]).to be_a(String)

      expect(roadtrip[:data][:attributes]).to have_key(:weather_at_eta)
      expect(roadtrip[:data][:attributes][:weather_at_eta]).to be_a(Hash)

      expect(roadtrip[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(roadtrip[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)

      expect(roadtrip[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
      expect(roadtrip[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
    end

    it 'returns 401 unauthorized without api_key' do
      unauthorized_params = { origin: 'San Antonio, TX', destination: 'Denver, CO' }
      get '/api/v1/roadtrip', params: unauthorized_params

      expect(response.status).to eq(401)
    end

    it 'returns impossible route for bad route' do
      VCR.use_cassette('impossible_route') do
        VCR.use_cassette('impossible_weather') do
          roadtrip_params = { origin: 'New York, NY', destination: 'London, UK', api_key: @user[:data][:attributes][:api_key] }
          get '/api/v1/roadtrip', params: roadtrip_params
          impossible = JSON.parse(response.body, symbolize_names: true)

          expect(response).to be_successful

          expect(impossible).to be_a(Hash)
          expect(impossible).to have_key(:data)
          expect(impossible[:data]).to be_a(Hash)

          expect(impossible[:data]).to have_key(:id)
          expect(impossible[:data][:id]).to eq(nil)

          expect(impossible[:data]).to have_key(:type)
          expect(impossible[:data][:type]).to eq("roadtrip")

          expect(impossible[:data]).to have_key(:attributes)
          expect(impossible[:data][:attributes]).to be_a(Hash)

          expect(impossible[:data][:attributes]).to have_key(:start_city)
          expect(impossible[:data][:attributes][:start_city]).to be_a(String)

          expect(impossible[:data][:attributes]).to have_key(:end_city)
          expect(impossible[:data][:attributes][:end_city]).to be_a(String)

          expect(impossible[:data][:attributes]).to have_key(:travel_time)
          expect(impossible[:data][:attributes][:travel_time]).to eq("Impossible route")

          expect(impossible[:data][:attributes]).to have_key(:weather_at_eta)
          expect(impossible[:data][:attributes][:weather_at_eta]).to eq(nil)
        end
      end
    end
  end
end
