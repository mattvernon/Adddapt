class AddStatusToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :status, :string
  end
end
