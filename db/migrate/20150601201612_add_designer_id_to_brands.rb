class AddDesignerIdToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :designer_id, :integer
    add_index :brands, :designer_id
  end
end
