class AddProfilePartnerships < ActiveRecord::Migration[8.0]
  def up
    drop_table :partnerships, if_exists: true

    create_table :partnerships do |t|
      t.references :from_profile, null: false, foreign_key: { to_table: :profiles }
      t.references :to_profile, null: false, foreign_key: { to_table: :profiles }
      t.integer :status, null: false

      t.timestamps
    end

    add_index :partnerships, [:from_profile_id, :to_profile_id], unique: true
    add_index :partnerships, [:to_profile_id, :from_profile_id], unique: true
    add_index :partnerships, [:from_profile_id, :status]
  end

  def down
    drop_table :partnerships, if_exists: true
  end
end
