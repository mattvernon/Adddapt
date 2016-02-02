class AddAttachmentProfilePicToDesigners < ActiveRecord::Migration
  def self.up
    change_table :designers do |t|
      t.attachment :profile_pic
    end
  end

  def self.down
    remove_attachment :designers, :profile_pic
  end
end
