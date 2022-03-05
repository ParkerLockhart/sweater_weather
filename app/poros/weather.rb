class Weather
  attr_reader :current_weather, :daily_weather, :hourly_weather

  def initialize(data)
    @current_weather = CurrentWeather.new(data[:current])
    @daily_weather = data[:daily].map { |day| DailyWeather.new(day) }
    @hourly_weather = data[:hourly].map { |hour| HourlyWeather.new(hour) }
  end
end
