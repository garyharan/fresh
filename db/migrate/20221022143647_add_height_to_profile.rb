class AddHeightToProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :height, :integer
  end
end
