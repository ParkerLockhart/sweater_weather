require 'rails_helper'

RSpec.describe HourlyWeather do
  let!(:data) { JSON.parse(File.read('spec/support/hourly_weather.json'), symbolize_names: true) }
  let!(:hourly) { HourlyWeather.new(data) }

  it 'exists' do
    expect(hourly).to be_instance_of(HourlyWeather)
  end

  it 'has attributes' do
    expect(hourly.time).to eq("13:00 -0600")
    expect(hourly.temperature).to eq(59.67)
    expect(hourly.conditions).to eq("scattered clouds")
    expect(hourly.icon).to eq("03d")
  end
end
