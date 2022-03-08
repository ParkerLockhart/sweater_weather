class ApplicationController < ActionController::API
  def geo(city)
    if Geolocation.where("city = ?", city).exists?
      @location = Geolocation.find_by(city: city)
    else
      @location = LocationFacade.lat_lng(city)
      Geolocation.create(@location.as_json)
    end
  end

  def require_user
    if !authorized_user
      render json: {
        error: "Invalid api_key.",
      },
      status: :unauthorized
    end
  end

  def authorized_user
    User.find_by api_key: params[:api_key]
  end
end
