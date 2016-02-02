class CombineItemsInCart < ActiveRecord::Migration
  def up
    # replace all multiple items for a single brand in a cart with a single item
    Cart.all.each do |cart|
      # count the number of each brand in the cart
      sums = cart.line_items.group(:brand_id).sum(:quantity)

      sums.each do |brand_id, quantity|
        if quantity > 1
          # remove individual items
          cart.line_items.where(brand_id: brand_id).delete_all

          # replace with a single item
          cart.line_items.where(brand_id: brand_id, quantity: quantity)
        end
      end
    end
  end

  def down
    # split items with quantity>1 into multiple items
    LineItem.where("quantity>1").each do |line_item|
      # add individual items
      line_item.quantity.times do
        LineItem.create cart_id: line_item.cart_id, brand_id: line_item.brand_id, quantity: 1
      end
      # remove original item
      line_item.destroy
    end
  end
end
