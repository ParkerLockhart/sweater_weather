class WeatherFacade

  def self.daily_weather(lat, lon)
    WeatherService.one_call(lat, lon)[:daily].first(5).map do |data|
      DailyWeather.new(data)
    end
  end

  def self.current_weather(lat, lon)
    CurrentWeather.new(WeatherService.one_call(lat, lon)[:current])
  end

  def self.hourly_weather(lat, lon)
    WeatherService.one_call(lat, lon)[:hourly].first(8).map do |data|
      HourlyWeather.new(data)
    end
  end

  def self.full_weather(lat, lon)
    Weather.new(WeatherService.one_call(lat, lon))
  end
end
