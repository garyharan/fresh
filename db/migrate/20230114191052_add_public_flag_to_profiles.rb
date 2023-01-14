class AddPublicFlagToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :public, :boolean, default: false
    add_column :profiles, :public_code, :string, unique: true
  end
end
