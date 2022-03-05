require 'rails_helper'

RSpec.describe WeatherService do
  describe 'class methods' do
    describe 'one_call' do
      before(:each) do
        VCR.insert_cassette('san_antonio_weather')
      end
      after(:each) do
        VCR.eject_cassette('san_antonio_weather')
      end

      let!(:weather) {WeatherService.one_call(29.425173, -98.494599)}

      it 'returns response hash' do
        expect(weather).to be_a(Hash)
      end

      it 'response hash has current weather data' do
        expect(weather).to have_key(:current)
        expect(weather[:current]).to be_a(Hash)

        expect(weather[:current]).to have_key(:dt)
        expect(weather[:current][:dt]).to be_an(Integer)

        expect(weather[:current]).to have_key(:sunrise)
        expect(weather[:current][:sunrise]).to be_an(Integer)

        expect(weather[:current]).to have_key(:sunset)
        expect(weather[:current][:sunset]).to be_an(Integer)

        expect(weather[:current]).to have_key(:temp)
        expect(weather[:current][:temp]).to be_a(Float)

        expect(weather[:current]).to have_key(:feels_like)
        expect(weather[:current][:feels_like]).to be_a(Float)

        expect(weather[:current]).to have_key(:humidity)
        expect(weather[:current][:humidity]).to be_an(Integer)

        expect(weather[:current]).to have_key(:uvi)
        expect(weather[:current][:uvi]).to be_a(Float)

        expect(weather[:current]).to have_key(:visibility)
        expect(weather[:current][:visibility]).to be_an(Integer)

        expect(weather[:current]).to have_key(:weather)
        expect(weather[:current][:weather]).to be_an(Array)

        expect(weather[:current][:weather].first).to be_a(Hash)
        expect(weather[:current][:weather].first).to have_key(:description)
        expect(weather[:current][:weather].first[:description]).to be_a(String)
        expect(weather[:current][:weather].first).to have_key(:icon)
        expect(weather[:current][:weather].first[:icon]).to be_a(String)
      end

      it 'response hash has daily weather data' do
        expect(weather).to have_key(:daily)
        expect(weather[:daily]).to be_an(Array)
        expect(weather[:daily].count).to eq(8)

        first = weather[:daily].first

        expect(first).to have_key(:dt)
        expect(first[:dt]).to be_an(Integer)

        expect(first).to have_key(:sunrise)
        expect(first[:sunrise]).to be_an(Integer)

        expect(first).to have_key(:sunset)
        expect(first[:sunset]).to be_an(Integer)

        expect(first).to have_key(:temp)
        expect(first[:temp]).to be_a(Hash)

        expect(first[:temp]).to have_key(:max)
        expect(first[:temp][:max]).to be_a(Float)

        expect(first[:temp]).to have_key(:min)
        expect(first[:temp][:min]).to be_a(Float)

        expect(first).to have_key(:weather)
        expect(first[:weather]).to be_an(Array)
        expect(first[:weather].first).to be_a(Hash)
        expect(first[:weather].first).to have_key(:description)
        expect(first[:weather].first[:description]).to be_a(String)
        expect(first[:weather].first).to have_key(:icon)
        expect(first[:weather].first[:icon]).to be_a(String)
      end

      it 'response hash has hourly weather data' do
        expect(weather).to have_key(:hourly)
        expect(weather[:hourly]).to be_an(Array)
        expect(weather[:hourly].count).to eq(48)

        first = weather[:hourly].first

        expect(first).to be_a(Hash)
        expect(first).to have_key(:dt)
        expect(first[:dt]).to be_an(Integer)

        expect(first).to have_key(:temp)
        expect(first[:temp]).to be_a(Float)

        expect(first).to have_key(:weather)
        expect(first[:weather]).to be_an(Array)
        expect(first[:weather].first).to be_a(Hash)
        expect(first[:weather].first).to have_key(:description)
        expect(first[:weather].first[:description]).to be_a(String)
        expect(first[:weather].first).to have_key(:icon)
        expect(first[:weather].first[:icon]).to be_a(String)
      end
    end
  end
end
