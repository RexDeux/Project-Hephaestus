class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_cart, :current_user

  def current_cart
    if session[:cart_id]
      cart = Cart.find_by(:id => session[:cart_id])
      if cart.present?
        @current_cart = cart
      else
        session[:cart_id] = nil
      end
    end

    if session[:cart_id].nil?
      @current_cart = Cart.create
      session[:cart_id] = @current_cart.id
    end
  end

  def current_user
    if session[:user_id]
      user = User.find_by(:id => session[:user_id])
    end
  end

end
