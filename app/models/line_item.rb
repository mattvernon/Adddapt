class LineItem < ActiveRecord::Base
  belongs_to :brand
  belongs_to :cart
  belongs_to :order

  def total_item_price
    brand.price * quantity
  end
end
