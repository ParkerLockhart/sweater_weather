require 'rails_helper'

RSpec.describe 'Forecast Endpoint' do
  describe 'GET forecast' do
    before(:each) do
      VCR.insert_cassette('san_antonio')
      VCR.insert_cassette('san_antonio_weather')
      get '/api/v1/forecast?location=san%20antonio,tx'
    end
    after(:each) do
      VCR.eject_cassette('san_antonio')
      VCR.eject_cassette('san_antonio_weather')
    end

    let!(:forecast) { JSON.parse(response.body, symbolize_names: true) }
    let!(:attributes) { forecast[:data][:attributes] }

    it 'returns successful' do
      expect(response).to be_successful
    end

    it 'returns correct outer structure' do
      expect(forecast).to have_key(:data)
      expect(forecast[:data]).to be_a(Hash)

      expect(forecast[:data]).to have_key(:id)
      expect(forecast[:data][:id]).to eq(nil)

      expect(forecast[:data]).to have_key(:type)
      expect(forecast[:data][:type]).to eq('forecast')

      expect(forecast[:data]).to have_key(:attributes)
      expect(forecast[:data][:attributes]).to be_a(Hash)
    end

    it 'has current weather info' do
      expect(attributes).to have_key(:current_weather)
      expect(attributes[:current_weather]).to be_a(Hash)

      current = attributes[:current_weather]

      expect(current).to have_key(:datetime)
      expect(current[:datetime]).to be_a(String)

      expect(current).to have_key(:sunrise)
      expect(current[:sunrise]).to be_a(String)

      expect(current).to have_key(:sunset)
      expect(current[:sunset]).to be_a(String)

      expect(current).to have_key(:temperature)
      expect(current[:temperature]).to be_a(Float)

      expect(current).to have_key(:feels_like)
      expect(current[:feels_like]).to be_a(Float)

      expect(current).to have_key(:humidity)
      expect(current[:humidity]).to be_an(Integer)

      expect(current).to have_key(:uvi)
      expect(current[:uvi]).to be_a(Float).or eq(0)

      expect(current).to have_key(:visibility)
      expect(current[:visibility]).to be_an(Integer)

      expect(current).to have_key(:conditions)
      expect(current[:conditions]).to be_a(String)

      expect(current).to have_key(:icon)
      expect(current[:icon]).to be_a(String)

      expect(current).to_not have_key(:pressure)
      expect(current).to_not have_key(:dew_point)
      expect(current).to_not have_key(:clouds)
      expect(current).to_not have_key(:wind_speed)
      expect(current).to_not have_key(:wind_deg)
    end

    it 'has daily weather info' do
      expect(attributes).to have_key(:daily_weather)
      expect(attributes[:daily_weather]).to be_an(Array)
      expect(attributes[:daily_weather].count).to eq(5)

      day = attributes[:daily_weather].first

      expect(day).to be_a(Hash)
      expect(day).to have_key(:date)
      expect(day[:date]).to be_a(String)

      expect(day).to have_key(:sunrise)
      expect(day[:sunrise]).to be_a(String)

      expect(day).to have_key(:sunset)
      expect(day[:sunset]).to be_a(String)

      expect(day).to have_key(:max_temp)
      expect(day[:max_temp]).to be_a(Float)

      expect(day).to have_key(:min_temp)
      expect(day[:min_temp]).to be_a(Float)

      expect(day).to have_key(:conditions)
      expect(day[:conditions]).to be_a(String)

      expect(day).to have_key(:icon)
      expect(day[:icon]).to be_a(String)

      expect(day).to_not have_key(:moonrise)
      expect(day).to_not have_key(:moonset)
      expect(day).to_not have_key(:moon_phase)
      expect(day).to_not have_key(:pressure)
      expect(day).to_not have_key(:dew_point)
      expect(day).to_not have_key(:wind_speed)
      expect(day).to_not have_key(:wind_deg)
    end

    it 'has hourly weather info' do
      expect(attributes).to have_key(:hourly_weather)
      expect(attributes[:hourly_weather]).to be_an(Array)
      expect(attributes[:hourly_weather].count).to eq(8)

      hour = attributes[:hourly_weather].first

      expect(hour).to be_a(Hash)
      expect(hour).to have_key(:time)
      expect(hour[:time]).to be_a(String)

      expect(hour).to have_key(:temperature)
      expect(hour[:temperature]).to be_a(Float)

      expect(hour).to have_key(:conditions)
      expect(hour[:conditions]).to be_a(String)

      expect(hour).to have_key(:icon)
      expect(hour[:icon]).to be_a(String)

      expect(hour).to_not have_key(:pressure)
      expect(hour).to_not have_key(:dew_point)
      expect(hour).to_not have_key(:clouds)
      expect(hour).to_not have_key(:wind_speed)
      expect(hour).to_not have_key(:wind_deg)
      expect(hour).to_not have_key(:wind_gust)
    end

    it 'does not have minutely info' do
      expect(forecast).to_not have_key(:minutely)
      expect(forecast).to_not have_key(:alerts)
    end
  end

end
