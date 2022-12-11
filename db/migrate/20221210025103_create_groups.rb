class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :description

      t.timestamps
    end

    create_table :groups_users, id: false do |t|
      t.belongs_to :group
      t.belongs_to :user
    end

    add_column :users, :group_owner, :boolean, default: false
  end
end
