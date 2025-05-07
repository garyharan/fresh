class CreateNotificationTokens < ActiveRecord::Migration[8.0]
  def change
    create_table :notification_tokens do |t|
      t.references :user, null: false, foreign_key: true
      t.string :token, null: false
      t.string :platform, null: false

      t.timestamps
    end
  end
end
