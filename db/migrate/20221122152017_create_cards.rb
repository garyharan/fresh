class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.string :title
      t.string :content
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
