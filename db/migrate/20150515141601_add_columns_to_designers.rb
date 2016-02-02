class AddColumnsToDesigners < ActiveRecord::Migration
  def change
    add_column :designers, :first_name, :string
    add_column :designers, :last_name, :string
    add_column :designers, :bio, :text
    add_column :designers, :location, :string
    add_column :designers, :facebook_url, :string
    add_column :designers, :twitter_url, :string
    add_column :designers, :dribbble_url, :string
  end
end
