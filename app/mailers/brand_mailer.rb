class BrandMailer < ApplicationMailer
  default from: "hello@alwaysnevercreative.com"

  def brand_upload_email(brand)
    @brand = brand
    mail(to: @brand.designer.email, subject: "You just uploaded your first brand!")
  end
end
