class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  # Basic authentication for charging
  # customers index page.
  helper_method :login?

  def logged_in?
    session[:login]
  end

  def authenticate
    login = authenticate_or_request_with_http_basic do |username, password|
      username == ENV['USERNAME'] && password == ENV['PASSWORD']
    end
    session[:login] = login
  end

  def do_logout
    session[:login] = nil
  end

  def current_cart
    # starts by finding a cart from session
    Cart.find(session[:cart_id])
    # rescue for when no cart is found
    # results in cart creation and
    # assignment of cart to session
    # and finally return said cart
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

  def current_brand 
    return unless session[:brand_id]
    @current_brand ||= Brand.find(session[:brand_id])
  end
  helper_method :current_brand
end
