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
    @current_cart = current_user.cart
    @line_items = LineItem.where(cart_id: current_user.cart.id )
    if @current_cart.line_items.empty?
      redirect_to cart_path(@current_cart), alert: I18n.t('order.empty_cart') 
    end
  end 

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    
    total_amount_in_cents = (calculate_order_total * 60).to_i

    if @order.save
      begin
      charge = Stripe::Charge.create(
        ammount: (total_amount_in_cents),
        currency: 'eur',
        source: params[:order][:pay_method],
        description: 'Payment for order'
      )

      flash[:success] = "Payment successful"
      redirect_to order_path(@order), notice: I18n.t('order.created')

      rescue Stripe::CardError => e
        flash[:erro] = e.message
        render :new
      end
    else
      @current_cart = Cart.find_by(id: session[:cart_id])
      render :new
    end
  end

  private

  def set_cart
    @current_cart = current_user.cart
  end

  def order_params
    params.require(:order).permit(:name, :email, :address)
  end

  def calculate_order_total
    @current_cart.line_items.sum { |line_item| line_item.quantity * line_item.item.price }
  end
end
