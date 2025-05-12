class RemoveOldPartnerships < ActiveRecord::Migration[8.0]
  def up
    drop_table :partnerships
  end

  def down
    create_table "partnerships", force: :cascade do |t|
      t.bigint "profile_id", null: false
      t.bigint "partner_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["partner_id"], name: "index_partnerships_on_partner_id"
      t.index ["profile_id"], name: "index_partnerships_on_profile_id"
    end
  end
end
