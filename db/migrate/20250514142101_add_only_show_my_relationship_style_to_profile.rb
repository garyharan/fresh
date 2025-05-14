class AddOnlyShowMyRelationshipStyleToProfile < ActiveRecord::Migration[8.0]
  def change
    add_column :profiles, :only_show_my_relationship_style, :boolean, default: false
    add_index :profiles, :only_show_my_relationship_style
  end
end
