class CreatePartnerships < ActiveRecord::Migration[8.0]
  def change
    create_table :partnerships do |t|
      t.references :from_profile, null: false, foreign_key: { to_table: :profiles }
      t.references :to_profile, null: false, foreign_key: { to_table: :profiles }
      t.integer :status, null: false, default: 0  # pending by default
      t.timestamps
    end

    add_index :partnerships, [:from_profile_id, :to_profile_id], unique: true
  end
end
