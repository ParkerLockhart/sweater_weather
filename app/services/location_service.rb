class LocationService

  def self.post_url(body)
    response = Faraday.post("http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['map_api_key']}", body.to_json)
    parsed = JSON.parse(response.body, symbolize_names: true)
  end

  def self.city_to_latlng(city)
    body = {
            location: city,
            options: {
              "thumbMaps": false
              }
            }

    post_url(body)
  end
end
