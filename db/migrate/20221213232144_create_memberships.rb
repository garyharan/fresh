class CreateMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false
      t.boolean :revoked, default: false

      t.timestamps
    end
  end
end
