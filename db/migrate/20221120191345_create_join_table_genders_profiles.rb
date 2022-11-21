class CreateJoinTableGendersProfiles < ActiveRecord::Migration[7.0]
  def change
    create_join_table :genders, :profiles do |t|
      t.index %i[gender_id profile_id]
    end
    remove_column :profiles, :gender
  end
end
