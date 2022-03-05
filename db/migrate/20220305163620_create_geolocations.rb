class CreateGeolocations < ActiveRecord::Migration[7.0]
  def change
    create_table :geolocations do |t|
      t.string :city
      t.string :lat
      t.string :lng

      t.timestamps
    end
  end
end
