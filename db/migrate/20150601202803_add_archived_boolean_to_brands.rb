class AddArchivedBooleanToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :archived, :boolean, :default => "false"
  end
end
