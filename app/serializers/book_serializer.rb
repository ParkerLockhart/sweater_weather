class BookSerializer

  def self.book_search(weather, books, location)
    { "data": {
      "id": "null",
      "type": "books",
      "attributes": {
        "destination:" location,
        "forecast": {
          "summary": weather.conditions,
          "temperature": "#{weather.temp} F"
        },
        "total_books_found": books.first,
        "books": books.last
      }
      }
    }
  end
end
