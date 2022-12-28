class AddNanoIdForGroupUrls < ActiveRecord::Migration[7.0]
  def change
    add_column :groups, :slug, :string
    add_index :groups, :slug, unique: true
  end
end
