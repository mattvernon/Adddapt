class Designer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:stripe_connect]

  has_attached_file :profile_pic,
                    :styles => { :medium => "100x100>", :thumb => "28x28>"},
                    :default_url => "missing_:style.png"
                    
  validates_attachment_content_type :profile_pic, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  has_many :brands

  after_create :send_welcome_email_to_designer

  def full_name
    [first_name, last_name].join(' ')
  end

  private

  def send_welcome_email_to_designer
    DesignerMailer.welcome_email(self).deliver_later
  end
end
