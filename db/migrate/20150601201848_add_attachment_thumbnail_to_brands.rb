class AddAttachmentThumbnailToBrands < ActiveRecord::Migration
  def self.up
    change_table :brands do |t|
      t.attachment :thumbnail
    end
  end

  def self.down
    remove_attachment :brands, :thumbnail
  end
end
