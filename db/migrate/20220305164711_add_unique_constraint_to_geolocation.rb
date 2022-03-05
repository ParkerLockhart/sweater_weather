class AddUniqueConstraintToGeolocation < ActiveRecord::Migration[7.0]
  def change
    add_index :geolocations, :city, unique: true
  end
end
