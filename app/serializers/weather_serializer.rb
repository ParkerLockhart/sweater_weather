class WeatherSerializer
  include JSONAPI::Serializer
  attributes :current_weather, :daily_weather, :hourly_weather
  set_type :forecast
  set_id nil
end
