class AddTimestampsToBrand < ActiveRecord::Migration
  def change
    add_column :brands, :created_at, :datetime
    add_column :brands, :updated_at, :datetime
  end
end
