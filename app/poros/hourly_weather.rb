class HourlyWeather
  attr_reader :dt, :temp, :conditions, :icon

  def initialize(data)
    @dt = Time.at(data[:dt]).to_datetime
    @temp = data[:temp]
    @conditions = data[:weather].first[:description]
    @icon = data[:weather].first[:icon]
  end
end
 
