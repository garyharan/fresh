class AddGeoToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :lat, :float
    add_column :profiles, :lon, :float
    add_column :profiles, :county, :string
    add_column :profiles, :city, :string
    add_column :profiles, :country_code, :string
  end
end
