class AddMaximumDistanceToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :maximum_distance, :integer, default: 50_000
  end
end
