class LineItemsController < ApplicationController

  def show
    @line_item = LineItem.find(params[:id])
    head :no_content
  end

  def create
    @chosen_item = Item.find(params[:item_id])
    current_cart = @current_cart

    if @chosen_item.quantity <= 0
      redirect_to item_path(@chosen_item), alert: I18n.t('item.out_of_stock')
      return
    end

    if current_cart.items.include?(@chosen_item)
      @line_item = current_cart.line_items.find_by(item_id: @chosen_item.id)
      @line_item.quantity += 1 && @chosen_item.quantity -= 1
    else
      @line_item = current_cart.line_items.new(item: @chosen_item, quantity: 1)
    end

    @chosen_item.quantity -= 1
    @chosen_item.save

    if @line_item.save
      redirect_to cart_path(current_cart), notice: I18n.t('item.added_to_cart')
    else
      redirect_to item_path(@chosen_item), alert: 'There was an issue adding the item to your cart.'
    end
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @chosen_item = @line_item.item
    
    # Update item quantity in stock
    @chosen_item.quantity += @line_item.quantity
    @chosen_item.save
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
      @line_item.save
    elsif @line_item == 1 
      @line_item.destroy
    end
    redirect_to cart_path(@current_cart)
  end

  private
  def line_item_params
    params.require(@line_item).permit(:item_id)
  end
end
