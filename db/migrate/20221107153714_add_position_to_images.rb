class AddPositionToImages < ActiveRecord::Migration[7.0]
  def change
    add_column :images, :position, :integer
    Image
      .order(:updated_at)
      .each
      .with_index(0) { |image, index| image.update_column :position, index }
  end
end
