class BookService

  def self.get_url(url)
    response = Faraday.get("http://openlibrary.org#{url}")
    parsed = JSON.parse(response.body, symbolize_names: true)
  end

  def self.book_search(city)
    get_url("/search.json?subject=travel&place=#{city}")
  end
end
