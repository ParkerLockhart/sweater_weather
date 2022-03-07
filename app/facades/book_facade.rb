class BookFacade

  def self.book_search(city, num)
    search = BookService.book_search(city)
    books = search[:docs].first(num).map do |data|
      Book.new(data)
    end
    total = search[:numFound]
    result = [total, books]
  end
end
