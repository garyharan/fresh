class AddImagesCountToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :images_count, :integer, default: 0
    Profile.all.each { |profile| Profile.reset_counters(profile.id, :images) }
  end
end
