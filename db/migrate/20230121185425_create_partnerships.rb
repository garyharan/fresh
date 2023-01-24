class CreatePartnerships < ActiveRecord::Migration[7.0]
  def change
    create_table :partnerships do |t|
      t.references :profile, null: false
      t.references :partner, null: false

      t.timestamps
    end
  end
end
