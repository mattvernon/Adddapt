class Charge < ActiveRecord::Base
  belongs_to :customer

  after_create :send_deposit_email

  private

  def send_deposit_email
    ChargeMailer.send_deposit_email(self).deliver_later
  end
end
