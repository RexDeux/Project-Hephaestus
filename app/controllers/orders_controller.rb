class OrdersController < ApplicationController

  before_action :set_cart, only: [:new, :create]
  
  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new()
    @current_cart = Cart.find_by(id: session[:cart_id])
    @line_items = LineItem.where(cart_id: @current_cart.id )
    if @current_cart.line_items.empty?
      redirect_to cart_path(@current_cart), alert: I18n.t('order.empty_cart') 
    end
  end 

  def create
    @order = Order.new(order_params)
    @order.user = current_user

    if @order.save
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      redirect_to order_path(@order), notice: I18n.t('order.created')
    else
      @current_cart = current_cart
      render :new
    end
  end

  private

  def set_cart
    @current_cart = Cart.where(id: session[:cart_id])
  end

  def order_params
    params.require(:order).permit(:name, :email, :address, :pay_method)
  end

  def calculate_order_total
    @cart.line_items.sum { |line_item| line_item_quantity * line_item.item.price }
  end

end
