require 'rails_helper'

RSpec.describe Roadtrip do
  let!(:start_city) {'san antonio, tx'}
  let!(:end_city) {'denver, co'}
  let!(:travel_time) {'14hrs, 21mins'}
  let!(:weather) { { temp: 59.4, weather: [{ description: 'scattered showers'}] } }
  let!(:data) { {start_city: start_city, end_city: end_city, travel_time: travel_time, weather: weather} }
  let!(:roadtrip) {Roadtrip.new(data)}

  it 'exists' do
    expect(roadtrip).to be_instance_of(Roadtrip)
  end

  it 'has attributes' do
    expect(roadtrip.id).to eq(nil)
    expect(roadtrip.start_city).to eq('san antonio, tx')
    expect(roadtrip.end_city).to eq('denver, co')
    expect(roadtrip.travel_time).to eq('14hrs, 21mins')
    expect(roadtrip.weather_at_eta).to have_key(:temperature)
    expect(roadtrip.weather_at_eta[:temperature]).to eq(59.4)
    expect(roadtrip.weather_at_eta).to have_key(:conditions)
    expect(roadtrip.weather_at_eta[:conditions]).to eq('scattered showers')
  end

end
