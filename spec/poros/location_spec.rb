require 'rails_helper'

RSpec.describe Location do
  let!(:data) {['Washington,DC', {lat: '38.892062', lng: '-77.019912'}]}
  let!(:location) {Location.new(data)}

  it 'exists' do
    expect(location).to be_instance_of(Location)
  end

  it 'has lat' do
    expect(location.lat).to eq('38.892062')
  end

  it 'has lng' do
    expect(location.lng).to eq('-77.019912')
  end

  it 'has city' do
    expect(location.city).to eq('Washington,DC')
  end
end
