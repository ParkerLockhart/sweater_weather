class Location
  attr_reader :lat, :lng, :city

  def initialize(data)
    @lat = data.first[:lat]
    @lng = data.first[:lng]
    @city = data.last
  end
end 
