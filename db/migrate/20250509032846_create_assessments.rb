class CreateAssessments < ActiveRecord::Migration[8.0]
  def change
    create_table :assessments do |t|
      t.references :from_profile, null: false, foreign_key: { to_table: :profiles }
      t.references :to_profile, null: false, foreign_key: { to_table: :profiles }
      t.integer :kind, null: false

      t.timestamps
    end

    add_index :assessments, [:from_profile_id, :to_profile_id], unique: true
  end
end
