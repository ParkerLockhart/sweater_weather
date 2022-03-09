require 'rails_helper'

RSpec.describe DailyWeather do
  let!(:data) { JSON.parse(File.read('spec/support/daily_weather.json'), symbolize_names: true) }
  let!(:daily) { DailyWeather.new(data) }

  it 'exists' do
    expect(daily).to be_instance_of(DailyWeather)
  end

  it 'has attributes' do
    expect(daily.date).to be_instance_of(Date)
    expect(daily.sunrise).to eq("2022-03-05 11:00 -0600")
    expect(daily.sunset).to eq("2022-03-05 11:00 -0600")
    expect(daily.min_temp).to eq(36.36)
    expect(daily.max_temp).to eq(60.46)
    expect(daily.conditions).to eq("broken clouds")
    expect(daily.icon).to eq("04d")
  end
end
