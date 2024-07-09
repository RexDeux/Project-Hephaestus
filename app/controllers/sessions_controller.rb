class SessionsController < ApplicationController
  def create
    @user = User.find_by(username: params[:username])
    
    if @user
      session[:user_id] = @user.id
      create_cart_for_user(@user)
      session[:cart_id] = current_user.cart.id
      redirect_to dashboard_path
    else
      redirect_to login_path, notice: I18n.t('user.error')
    end
  end

  def destroy
    session[:user_id] = nil
    session[:cart_id] = nil
    redirect_to root_path, notice: I18n.t('user.log_out')
  end

  private
  
  def create_cart_for_user(user)
    unless current_user.cart
      current_cart = Cart.create(user: current_user)
    else
      current_cart = user.cart
      session[:cart_id] = current_user.cart.id
    end
  end
end
