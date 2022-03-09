class HourlyWeather
  attr_reader :time, :temperature, :conditions, :icon

  def initialize(data)
    @time = Time.at(data[:dt]).to_datetime.strftime("%H:%M %z")
    @temperature = data[:temp]
    @conditions = data[:weather].first[:description]
    @icon = data[:weather].first[:icon]
  end
end
