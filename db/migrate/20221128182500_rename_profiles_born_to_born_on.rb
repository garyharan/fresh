class RenameProfilesBornToBornOn < ActiveRecord::Migration[7.0]
  def change
    rename_column :profiles, :born, :born_on
  end
end
