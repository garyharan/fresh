class AddSettingsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :genders, :string
    add_column :users, :minimum_age, :integer
    add_column :users, :maximum_age, :integer
    add_column :users, :distance, :integer
    add_column :users, :freshness, :integer
  end
end
