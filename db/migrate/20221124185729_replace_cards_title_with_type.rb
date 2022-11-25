class ReplaceCardsTitleWithType < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :kind, :string
  end
end
