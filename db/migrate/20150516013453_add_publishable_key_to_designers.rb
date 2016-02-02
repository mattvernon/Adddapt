class AddPublishableKeyToDesigners < ActiveRecord::Migration
  def change
    add_column :designers, :publishable_key, :string
    add_column :designers, :provider, :string
    add_column :designers, :uid, :string
    add_column :designers, :access_code, :string
  end
end
