class PreviewImage < ActiveRecord::Base
  belongs_to :brand

  has_attached_file :image,
                    :styles => { :large => "506.531x425>"},
                    :default_url => "missing_:style.png"

  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

end
