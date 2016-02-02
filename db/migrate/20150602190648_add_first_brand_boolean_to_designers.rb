class AddFirstBrandBooleanToDesigners < ActiveRecord::Migration
  def change
    add_column :designers, :first_brand, :boolean, :default => "true"
  end
end
