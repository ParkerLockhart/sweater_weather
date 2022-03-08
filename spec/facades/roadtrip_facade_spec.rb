require 'rails_helper'

RSpec.describe RoadtripFacade do
  describe 'roadtrip' do
    it 'returns roadtrip object' do
      VCR.use_cassette('roadtrip') do
        VCR.use_cassette('denver_weather') do
          roadtrip = RoadtripFacade.roadtrip('San Antonio, TX', 'Denver, CO')

          expect(roadtrip).to be_instance_of(Roadtrip)
        end
      end
    end
  end

  describe 'route_info' do
    it 'returns trip time, destination lat/lng' do
      VCR.use_cassette('roadtrip') do
        route_info = RoadtripFacade.route_info('San Antonio, TX', 'Denver, CO')

        expect(route_info).to have_key(:time)
        expect(route_info[:time]).to eq(51687)

        expect(route_info).to have_key(:lat)
        expect(route_info[:lat]).to eq(39.738453)

        expect(route_info).to have_key(:lng)
        expect(route_info[:lng]).to eq(-104.984853)
      end
    end

    it 'returns impossible route if to/from incompatible' do
      VCR.use_cassette('impossible_route') do
        route_info = RoadtripFacade.route_info('New York, NY', 'London, UK')

        expect(route_info).to have_key(:time)
        expect(route_info[:time]).to eq("Impossible route")

        expect(route_info).to_not have_key(:lat)
        expect(route_info).to_not have_key(:lng)
      end
    end
  end

  describe 'time_offset' do
    it 'converts seconds to hours for weather request' do
      offset = RoadtripFacade.time_offset(7200)

      expect(offset).to eq(2)
    end
  end

  describe 'time_format' do
    it 'converts seconds to human readable format' do
       formatted = RoadtripFacade.time_format(12847)

       expect(formatted).to eq("3hrs, 34mins")
    end
  end

  describe 'weather_at_eta' do
    it 'returns weather info for estimated time of arrival' do
      VCR.use_cassette('roadtrip') do
        VCR.use_cassette('denver_weather') do
          route = RoadtripFacade.route_info('San Antonio, TX', 'Denver, CO')
          weather = RoadtripFacade.weather_at_eta(route)

          expect(weather).to be_a(Hash)
          expect(weather).to have_key(:temperature)
          expect(weather[:temperature]).to be_a(Float)
          expect(weather).to have_key(:conditions)
          expect(weather[:conditions]).to be_a(String)
        end
      end
    end

    it 'returns nil if impossible route' do
      VCR.use_cassette('impossible_route') do
        VCR.use_cassette('impossible_weather') do
          route = RoadtripFacade.route_info('New York, NY', 'London, UK')
          weather = RoadtripFacade.weather_at_eta(route)

          expect(weather).to eq(nil)
        end
      end
    end
  end

  describe 'travel_time' do
    it 'takes time from route_info to format_time' do
      VCR.use_cassette('roadtrip') do
        route = RoadtripFacade.route_info('San Antonio, TX', 'Denver, CO')

        travel_time = RoadtripFacade.travel_time(route[:time])

        expect(travel_time).to eq("14hrs, 21mins")
      end
    end

    it 'sends impossible route msg in event of impossible route' do
      VCR.use_cassette('impossible_route') do
        route = RoadtripFacade.route_info('New York, NY', 'London, UK')

        travel_time = RoadtripFacade.travel_time(route[:time])

        expect(travel_time).to eq("Impossible route")
      end
    end
  end

end
