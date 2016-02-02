class RemoveColumnStripeTokenFromCustomers < ActiveRecord::Migration
  def change
    remove_column :customers, :stripe_token, :string
  end
end
