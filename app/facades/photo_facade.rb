class PhotoFacade

  def self.random_img(city)
    data = Image.new([city, PhotoService.random_img(city)])
  end
end
