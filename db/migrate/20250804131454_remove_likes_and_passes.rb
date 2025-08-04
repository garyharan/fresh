class RemoveLikesAndPasses < ActiveRecord::Migration[8.0]
  def up
    remove_foreign_key :passes, :profiles if foreign_key_exists?(:passes, :profiles)
    remove_foreign_key :passes, :users if foreign_key_exists?(:passes, :users)

    remove_foreign_key :likes, :profiles if foreign_key_exists?(:likes, :profiles)
    remove_foreign_key :likes, :users if foreign_key_exists?(:likes, :users)

    drop_table :likes if table_exists?(:likes)
    drop_table :passes if table_exists?(:passes)
  end

  def down
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :liked_user, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end unless table_exists?(:likes)

    create_table :passes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :passed_user, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end unless table_exists?(:passes)
  end
end
