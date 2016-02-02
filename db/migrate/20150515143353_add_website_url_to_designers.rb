class AddWebsiteUrlToDesigners < ActiveRecord::Migration
  def change
    add_column :designers, :website_url, :string
  end
end
