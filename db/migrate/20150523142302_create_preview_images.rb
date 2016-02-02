class CreatePreviewImages < ActiveRecord::Migration
  def change
    create_table :preview_images do |t|

      t.timestamps null: false
    end
  end
end
