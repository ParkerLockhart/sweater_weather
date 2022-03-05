class Geolocation < ApplicationRecord
  validates :city, :lat, :lng, presence: true
end
