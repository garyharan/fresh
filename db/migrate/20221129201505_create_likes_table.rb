class CreateLikesTable < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.integer :profile_id
      t.integer :author_profile_id

      t.timestamps
    end
  end
end
