class Api::V1::ForecastController < ApplicationController
  def index
    location = geo(params[:location])
    weather = WeatherFacade.full_weather(location.lat, location.lng)
    render json: WeatherSerializer.new(weather)
  end
end
