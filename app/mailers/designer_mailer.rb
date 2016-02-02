class DesignerMailer < ApplicationMailer
  default from: "hello@alwaysnevercreative.com"

  def welcome_email(designer)
    @designer = designer
    mail(to: @designer.email, subject: "Welcome to Adddapt!")
  end
end
