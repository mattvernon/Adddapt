class Brand < ActiveRecord::Base
  scope :active, -> { where(:active => "true")}
  scope :archived, -> { where(archived: true)}

  belongs_to :designer

  has_many :preview_images

  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  validates_numericality_of :price, greater_than: 49

  accepts_nested_attributes_for :preview_images, allow_destroy: true

  validates :name, :description, :price, :presence => true

  has_attached_file :thumbnail,
                    :styles => { :thumb => "272.656x175>"},
                    :default_url => "missing_:style.png"
                    
  validates_attachment_content_type :thumbnail, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  after_create :send_first_brand_upload_email

  private
  
  # ensure no line items are referencing
  # a certain brand before an action
  # see before_destroy, above
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end

  def send_first_brand_upload_email
    if self.designer.first_brand == true
      BrandMailer.brand_upload_email(self).deliver_later
    end
  end

end
