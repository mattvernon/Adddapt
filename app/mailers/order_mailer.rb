class OrderMailer < ApplicationMailer
  default from: "hello@alwaysnevercreative.com"

  def sold_brand_email(order)
    @order = order
    mail(to: @order.line_items.last.brand.designer.email, subject: "You sold a brand!")
  end

  def send_invoice_email(order)
    @order = order
    mail(to: @order.email, subject: "Thanks for buying a brand!")
  end
end
