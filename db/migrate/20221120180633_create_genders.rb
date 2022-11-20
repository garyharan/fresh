class CreateGenders < ActiveRecord::Migration[7.0]
  def change
    create_table :genders do |t|
      t.string :label

      t.timestamps
    end

    add_column :profiles, :gender_id, :bigint

    add_index :profiles, :gender_id
  end
end
