class AddSmokingAndDrinkingToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :smoking, :string
    add_column :profiles, :drinking, :string
  end
end
