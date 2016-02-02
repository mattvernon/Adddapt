class AddStripeAccountTypeToDesigners < ActiveRecord::Migration
  def change
    add_column :designers, :stripe_account_type, :string
  end
end
