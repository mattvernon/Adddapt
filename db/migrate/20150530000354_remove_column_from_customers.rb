class RemoveColumnFromCustomers < ActiveRecord::Migration
  def change
    remove_column :customers, :customer_id, :string
  end
end
