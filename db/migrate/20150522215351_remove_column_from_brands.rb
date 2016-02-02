class RemoveColumnFromBrands < ActiveRecord::Migration
  def change
    remove_column :brands, :brand_id, :string
  end
end
