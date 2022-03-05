class DailyWeather
  attr_reader :dt, :sunrise, :sunset, :max_temp, :min_temp, :conditions, :icon

  def initialize(data)
    @dt = Time.at(data[:dt]).to_datetime
    @sunrise = Time.at(data[:dt]).to_datetime
    @sunset = Time.at(data[:dt]).to_datetime
    @max_temp = data[:temp][:max]
    @min_temp = data[:temp][:min]
    @conditions = data[:weather].first[:description]
    @icon = data[:weather].first[:icon]
  end
end
