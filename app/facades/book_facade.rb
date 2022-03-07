class BookFacade

  def self.book_search(city, num)
    BookService.book_search(city)[:docs].first(num).map do |data|
      Book.new(data)
    end
  end
end 
