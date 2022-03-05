class ApplicationController < ActionController::API
  def geo(city)
    if Geolocation.where("city = ?", city).exists?
      @location = Geolocation.find_by(city: city)
    else
      @location = LocationFacade.lat_lng(city)
      Geolocation.create(@location.as_json)
    end
  end
end
