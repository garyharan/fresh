class RemoveProfileBody < ActiveRecord::Migration[7.0]
  def change
    remove_column :profiles, :body, :text
  end
end
