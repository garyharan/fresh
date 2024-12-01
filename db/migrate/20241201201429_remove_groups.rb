class RemoveGroups < ActiveRecord::Migration[8.0]
  def change
    drop_table :groups
  end
end
