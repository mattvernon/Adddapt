class AddColumnsToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :designer_uid, :string
    add_column :customers, :amount, :integer
  end
end
