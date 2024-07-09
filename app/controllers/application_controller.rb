class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_cart, :current_user

  def current_cart
    if session[:cart_id]
      cart = Cart.find_by(:id => session[:cart_id])
      if !cart.present?
        @current_cart = build_cart
      end
    else
      @user = current_user
      @user.build_cart
    end
  end

  def current_user
    if session[:user_id]
      user = User.find_by(:id => session[:user_id])
    end
  end

  private
  def build_cart
    unless @user.cart
      # Build or find the user's cart
      @current_cart = @user.cart || Cart.new(user: @user) 
      @current_cart.save
      @user.update(cart_id: @current_cart.id)
      @current_cart =  @user.cart
    end
  end
end
