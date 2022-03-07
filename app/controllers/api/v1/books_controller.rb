class Api::V1::BooksController < ApplicationController
  def index
    location = geo(params[:location])
    weather = WeatherFacade.current_weather(location.lat, location.lng)
    books = BookFacade.book_search(params[:location], params[:quantity])
    BookSerializer.book_search(weather, books)
  end
end
