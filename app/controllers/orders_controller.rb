class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def new
    # checks cart to see if there are
    # items in it. If not, then the
    # user is redirected to the root_path
    @cart = current_cart
    if @cart.line_items.empty?
      redirect_to root_path, notice: "Your cart is empty"
      return
    end

    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @cart = current_cart

    # add line items from cart to order
    @order.add_line_items_from_current_cart(current_cart)
    
    # get the credit card details from submitted form
    token = params[:stripeToken]
    
    # create a customer
    customer = Stripe::Customer.create(
      :email => @order.email,
      :card => token,
      :description => "Purchase of #{@cart.line_items.last.brand.name} Brand for $#{@cart.total_cart_price}"
    )
    
    # create local customer record with
    # customer_id saved for later charging
    # and designer_uid for routing payment to
    # correct designer of brand
    @local_customer = Customer.new
    @local_customer.update_attributes(:stripe_customer_id => customer.id,
                                      :email => @order.email,
                                      :name => @order.name,
                                      :designer_uid => @order.line_items.last.brand.designer.designer_uid,
                                      :designer_email => @order.line_items.last.brand.designer.email,
                                      :amount => @cart.total_cart_price)
    @local_customer.save

    # TO DO
    # set brand to archived

    respond_to do |format|
      if @order.save
        # destroy cart after order is saved
        # set new session cart to nil
        @order.line_items.last.brand.archived = true
        @order.line_items.last.brand.active = false
        @order.line_items.last.brand.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        format.html { redirect_to root_path, notice: 'Thank you for your order.' }
        format.json { render :show, status: :created, location: @order }
      else
        # retain current cart if order is not saved
        @cart = current_cart
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:name, :email)
    end
end
