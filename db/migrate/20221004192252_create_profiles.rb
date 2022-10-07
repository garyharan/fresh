class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :display_name
      t.text :body
      t.date :born

      t.timestamps
    end
  end
end
