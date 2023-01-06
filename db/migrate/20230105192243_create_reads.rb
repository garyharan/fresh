class CreateReads < ActiveRecord::Migration[7.0]
  def change
    create_table :reads do |t|
      t.references :user, null: false, foreign_key: true
      t.references :message, null: false, foreign_key: true

      t.timestamps
    end
  end
end
