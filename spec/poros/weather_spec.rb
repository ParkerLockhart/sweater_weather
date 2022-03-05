require 'rails_helper'

RSpec.describe Weather do
  let!(:data) { JSON.parse(File.read('spec/support/weather_response.json'), symbolize_names: true) }
  let!(:weather) { Weather.new(data) }

  it 'exists' do
    expect(weather).to be_instance_of(Weather)
  end

  it 'has current_weather' do
    expect(weather.current_weather).to be_instance_of(CurrentWeather)
  end

  it 'has array of daily_weather objects' do
    weather.daily_weather.each do |daily|
      expect(daily).to be_instance_of(DailyWeather)
    end
  end

  it 'has array of hourly_weather objects' do
    weather.hourly_weather.each do |hourly|
      expect(hourly).to be_instance_of(HourlyWeather)
    end
  end
end
