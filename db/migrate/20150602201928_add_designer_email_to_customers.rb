class AddDesignerEmailToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :designer_email, :string
  end
end
