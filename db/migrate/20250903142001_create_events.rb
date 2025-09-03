class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :location
      t.float :latitude
      t.float :longitude
      t.datetime :start_time
      t.datetime :end_time
      t.integer :maximum_attendees
      t.boolean :allow_wait_list

      t.references :creator, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
