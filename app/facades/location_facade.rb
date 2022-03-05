class LocationFacade

  def self.lat_lng(city)
    data = Location.new([city, LocationService.city_to_latlng(city)[:results].first[:locations].first[:latLng]])
  end
end
