class WeatherService
  def self.one_call(lat, lon)
    conn = Faraday.new(url: "https://api.openweathermap.org") do |faraday|
      faraday.params[:lat] = lat
      faraday.params[:lon] = lon
      faraday.params[:exclude] = "minutely,alerts"
      faraday.params[:units] = "imperial"
      faraday.params[:appid] = ENV['weather_api_key']
    end

    response = conn.get("/data/2.5/onecall")
    JSON.parse(response.body, symbolize_names: true)
  end
end 
