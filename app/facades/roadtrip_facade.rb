class RoadtripFacade

  def self.roadtrip(from, to)
    route = route_info(from, to)
    Roadtrip.new({ start_city: from, end_city: to, travel_time: travel_time(route[:time]), weather: weather_at_eta(route) })
  end

  def self.route_info(from, to)
    route = LocationService.roadtrip(from, to)[:route]
    if route[:time]
      time = route[:time]
      dest_lat = route[:locations].last[:latLng][:lat]
      dest_lng = route[:locations].last[:latLng][:lng]
      { time: time, lat: dest_lat, lng: dest_lng }
    else
      { time: "Impossible route" }
    end
  end

  def self.time_offset(seconds)
    (seconds / 3600).to_i
  end

  def self.time_format(seconds)
    "#{(seconds / 3600).to_i}hrs, #{((seconds % 3600)/60).to_i }mins"
  end

  def self.weather_at_eta(route)
    if route[:time].class == Integer
      hourly = WeatherService.one_call(route[:lat], route[:lng])[:hourly][time_offset(route[:time])]
      weather = { temperature: hourly[:temp], conditions: hourly[:weather].first[:description] }
    else
      nil
    end
  end

  def self.travel_time(time)
    if time.class == Integer
      time_format(time)
    else
      time
    end
  end

end
