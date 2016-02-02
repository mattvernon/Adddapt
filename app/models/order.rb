class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  has_one :cart
  belongs_to :customer
  after_create :send_sold_brand_email
  after_create :send_invoice_email

  def add_line_items_from_current_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  private

  def send_sold_brand_email
    OrderMailer.sold_brand_email(self).deliver_later  
  end

  def send_invoice_email
    OrderMailer.send_invoice_email(self).deliver_later
  end
end
