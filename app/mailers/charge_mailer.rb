class ChargeMailer < ApplicationMailer
  default from: "hello@alwaysnevercreative.com"

  def send_deposit_email(charge)
    @charge = charge
    mail(to: @charge.customer.designer_email, subject: "Congratulations! We just your released funds!")
  end
end
