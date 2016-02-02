class ChangeStripeCustomerIdColumnName < ActiveRecord::Migration
  def change
    rename_column :customers, :stripe_customer_id, :customer_id
  end
end
