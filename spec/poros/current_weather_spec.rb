require 'rails_helper'

RSpec.describe CurrentWeather do
  let!(:data) { JSON.parse(File.read('spec/support/current_weather.json'), symbolize_names: true) }
  let!(:current) { CurrentWeather.new(data[:current]) }

  it 'exists' do
    expect(current).to be_instance_of(CurrentWeather)
  end

  it 'has attributes' do
    expect(current.dt).to be_instance_of(DateTime)
    expect(current.sunrise).to be_instance_of(DateTime)
    expect(current.sunset).to be_instance_of(DateTime)
    expect(current.temp).to eq(59.67)
    expect(current.feels_like).to eq(57.63)
    expect(current.humidity).to eq(49)
    expect(current.uvi).to eq(3.36)
    expect(current.visibility).to eq(10000)
    expect(current.conditions).to eq("scattered clouds")
    expect(current.icon).to eq("03d")
  end
end
