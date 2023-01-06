class AddPotToProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :pot, :boolean, default: false
  end
end
