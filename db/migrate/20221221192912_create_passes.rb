class CreatePasses < ActiveRecord::Migration[7.0]
  def change
    create_table :passes do |t|
      t.references :profile, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
