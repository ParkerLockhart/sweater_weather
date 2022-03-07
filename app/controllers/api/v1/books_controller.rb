class Api::V1::BooksController < ApplicationController
  def index
    location = geo(params[:location])
    weather = WeatherFacade.current_weather(location.lat, location.lng)
    city = params[:location].split(',').first
    books = BookFacade.book_search(city, params[:quantity])

    render json: BookSerializer.book_search(weather, books, location)
  end
end
