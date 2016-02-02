class RemoveStatusColumnFromBrands < ActiveRecord::Migration
  def change
    remove_column :brands, :status, :string
  end
end
