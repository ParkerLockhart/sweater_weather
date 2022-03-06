class ImageSerializer
  include JSONAPI::Serializer
  attributes :id, :location, :image_url, :credit
end 
