class AddAttachmentPreviewToBrands < ActiveRecord::Migration
  def self.up
    change_table :brands do |t|
      t.attachment :preview
    end
  end

  def self.down
    remove_attachment :brands, :preview
  end
end
