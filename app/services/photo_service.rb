class PhotoService

  def self.random_img(city)
    get_url("/random?client_id=#{ENV['photo_api_key']}&query=#{city}")
  end

  def self.get_url(url)
    response = Faraday.get("https://api.unsplash.com/photos#{url}")
    parsed = JSON.parse(response.body, symbolize_names: true)
  end
end
