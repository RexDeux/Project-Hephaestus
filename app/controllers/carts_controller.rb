class CartsController < ApplicationController

  def create
    @cart = @current_cart
    item = Item.find(params[:item_id])
  end

  def show
    @current_cart = Cart.find(params[:id])
  end

  def destroy
    @cart = @current_cart
    @cart.destroy
    session[:cart_id] = nil
    redirect_to root_path
  end
end
