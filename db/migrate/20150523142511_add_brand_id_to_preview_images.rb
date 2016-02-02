class AddBrandIdToPreviewImages < ActiveRecord::Migration
  def change
    add_column :preview_images, :brand_id, :integer
    add_index :preview_images, :brand_id
  end
end
