class LineItemsController < ApplicationController

  def create
    chosen_item = Item.find(params[:item_id])
    current_cart = @current_cart

    if current_cart.items.include?(chosen_item)

      @line_item = current_cart.line_item.find_by(:item_id => chosen_item)

      @line_item.quantity += 1
    else
      @line_item = LineItem.new
      @line_item.cart = current_cart
      @line_item.item = chosen_item
    end

    @line_item.save
    redirect_to cart_path(@current_cart)
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    redirect_to cart_path(@current_cart)
  end

  def add_quantity
    @line_item = LineItem.find(params[:id])
    @line_item.quantity += 1
    @line_item.save
    redirect_to cart_path(@current_cart)
  end

  def reduce_quantity
    @line_item = LineItem.find(params[:id])
    if @line_item.quantity > 1
      @line_item.quantity -= 1
    end
    @line_item.save
    redirect_to cart_path(@current_cart)
  end

  private
  def line_item_params
    params.require(:line_item).permit(:quantity, :item_id, :cart_id)
  end
end
