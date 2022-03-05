class Location
  attr_reader :lat, :lng, :city

  def initialize(data)
    @lat = data.last[:lat]
    @lng = data.last[:lng]
    @city = data.first
  end
end
