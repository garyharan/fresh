class AddRelationshipStyleToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :relationship_style, :string
  end
end
