class LocationService

  def self.post_url(url, body)
    response = Faraday.post("http://www.mapquestapi.com#{url}", body.to_json)
    parsed = JSON.parse(response.body, symbolize_names: true)
  end

  def self.city_to_latlng(city)
    url = "/geocoding/v1/address?key=#{ENV['map_api_key']}"
    body = {
            location: city,
            options: {
              "thumbMaps": false
              }
            }

    post_url(url, body)
  end

  def self.roadtrip(origin, destination)
    response = Faraday.get("http://www.mapquestapi.com/directions/v2/route?key=#{ENV['map_api_key']}") do |faraday|
      faraday.params['from'] = origin
      faraday.params['to'] = destination
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
