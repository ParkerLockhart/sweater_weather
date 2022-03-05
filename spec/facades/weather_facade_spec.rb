require 'rails_helper'

RSpec.describe WeatherFacade do
  describe 'full_weather' do
    it 'returns weather object' do
      VCR.use_cassette('san_antonio_weather') do
        weather = WeatherFacade.full_weather(29.425173, -98.494599)

        expect(weather).to be_instance_of(Weather)
      end
    end
  end
  describe 'current_weather' do
    it 'returns current weather object' do
      VCR.use_cassette('san_antonio_weather') do
        current_weather = WeatherFacade.current_weather(29.425173, -98.494599)
        expect(current_weather).to be_instance_of(CurrentWeather)
      end
    end
  end

  describe 'hourly_weather' do
    it 'returns array of 8 hourly weather objects' do
      VCR.use_cassette('san_antonio_weather') do
        hourly_weather = WeatherFacade.hourly_weather(29.425173, -98.494599)
        expect(hourly_weather).to be_an(Array)
        expect(hourly_weather.count).to eq(8)
        hourly_weather.each do |hourly|
          expect(hourly).to be_instance_of(HourlyWeather)
        end
      end
    end
  end

  describe 'daily_weather' do
    it 'returns array of 5 daily weather objects' do
      VCR.use_cassette('san_antonio_weather') do
        daily_weather = WeatherFacade.daily_weather(29.425173, -98.494599)
        expect(daily_weather).to be_an(Array)
        expect(daily_weather.count).to eq(5)
        daily_weather.each do |daily|
          expect(daily).to be_instance_of(DailyWeather)
        end
      end
    end
  end 
end
