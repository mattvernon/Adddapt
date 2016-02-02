class AddPriceColumnToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :price, :integer
  end
end
