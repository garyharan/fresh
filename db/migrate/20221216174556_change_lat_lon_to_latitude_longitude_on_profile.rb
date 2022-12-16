class ChangeLatLonToLatitudeLongitudeOnProfile < ActiveRecord::Migration[7.0]
  def change
    rename_column :profiles, :lat, :latitude
    rename_column :profiles, :lon, :longitude
  end
end
