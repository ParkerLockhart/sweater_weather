class WeatherSerializer
  include JSONAPI::Serializer
  attributes :id, :current_weather, :daily_weather, :hourly_weather
  set_type :forecast
end
