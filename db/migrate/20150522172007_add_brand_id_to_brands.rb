class AddBrandIdToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :brand_id, :integer
  end
end
