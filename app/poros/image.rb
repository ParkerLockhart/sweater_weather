class Image
  attr_reader :id, :location, :image_url, :credit

  def initialize(data)
    @id = "null"
    @location = data.first
    @image_url = data.last[:urls][:raw]
    @credit = { source: "https://unsplash.com", author: data.last[:user][:name] }
  end
end 
