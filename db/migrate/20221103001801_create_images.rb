class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.references :profile, null: false, foreign_key: true
      t.string :caption

      t.timestamps
    end
  end
end
