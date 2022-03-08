class RoadtripFacade

  def self.roadtrip(origin, destination)
    trip = LocationService.roadtrip(origin, destination)
    time = trip[:route][:time]
    time_offset = (time / 3600).to_i
    dest_lat = trip[:route][:locations].last[:latLng][:lat]
    dest_lng = trip[:route][:locations].last[:latLng][:lat]
    weather = WeatherService.one_call(dest_lat, dest_lng)[:hourly][time_offset]

    Roadtrip.new({
                  start_city: origin,
                  end_city: destination,
                  travel_time: "#{(time / 3600).to_i} hrs, #{((time % 3600)/60).to_i } mins",
                  weather: weather
                  })
  end
end
