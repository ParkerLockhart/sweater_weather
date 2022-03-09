class ImageSerializer
  include JSONAPI::Serializer
  attributes :location, :image_url, :credit
  set_id nil
end
