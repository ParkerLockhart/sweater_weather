class Roadtrip
  attr_reader :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(data)
    @start_city = data[:start_city]
    @end_city = data[:end_city]
    @travel_time = data[:travel_time]
    @weather_at_eta = { temperature: data[:weather][:temp], conditions: data[:weather][:weather][:description] }
  end
end
