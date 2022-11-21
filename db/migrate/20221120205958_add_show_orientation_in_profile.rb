class AddShowOrientationInProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :show_orientation, :boolean, default: false
  end
end
