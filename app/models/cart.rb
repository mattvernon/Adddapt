class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  belongs_to :order


  # method adds brand to cart
  # if brand is already in cart
  # quantity is increased rather
  # than adding a separate brand
  def add_brand(brand_id)
    current_item = line_items.find_by_brand_id(brand_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(brand_id: brand_id)
    end
    current_item
  end

  def total_cart_price
    line_items.to_a.sum do |item|
      item.total_item_price
    end
  end
end
