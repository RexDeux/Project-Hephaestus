class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]

  def index
    @carts = Cart.all
  end

  def show
    @cart = current_user.cart
  end

  def new
    @cart = Cart.new
  end

  def create
    @cart = create_cart_for_user(current_user)
    if @cart.save
      redirect_to @cart, notice: 'Cart was successfully created.'
    else
      render :new
    end
  end

  def update
    if @cart.update(cart_params)
      redirect_to @cart, notice: 'Cart was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @cart.destroy
    redirect_to carts_url, notice: 'Cart was successfully destroyed.'
  end

  private

  def set_cart
    @cart = Cart.find(params[:id])
  end

  def create_cart_for_user(user)
    if user.cart.nil?
      # Create a cart with all attributes
      current_cart = Cart.create(user: user)
      session[:cart_id] = current_cart.id
      current_cart
    else
      user.cart
    end
  end

  def cart_params
    params.require(:cart).permit(:user_id)
  end
end