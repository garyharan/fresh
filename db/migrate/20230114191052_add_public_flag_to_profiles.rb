class AddPublicFlagToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :public, :boolean, default: false
    add_column :profiles, :public_code, :string, unique: true

    Profile.find_each do |profile|
      profile.update_column(:public_code, profile.send(:generate_id))
    end
  end
end
