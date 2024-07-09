class LineItemsController < ApplicationController
  before_action :set_line_item, only: [:show, :destroy, :add_quantity, :reduce_quantity]

  def show
    head :no_content
  end

  def create
    @chosen_item = Item.find(params[:item_id])
    @current_cart = current_user.cart

    if @chosen_item.quantity <= 0
      redirect_to item_path(@chosen_item), alert: I18n.t('item.out_of_stock')
      return
    end

    @line_item = @current_cart.line_items.find_or_initialize_by(item_id: @chosen_item.id)
    if @line_item.new_record?
      @line_item.quantity = 0
    end

    if @line_item.quantity < @chosen_item.quantity
      @line_item.quantity += 1
      @chosen_item.quantity -= 1

      if @line_item.save && @chosen_item.save
        redirect_to cart_path(@current_cart), notice: I18n.t('item.added_to_cart')
      else
        redirect_to item_path(@chosen_item), alert: 'There was an issue adding the item to your cart.'
      end
    else
      redirect_to item_path(@chosen_item), alert: 'This item is already at its maximum quantity in your cart.'
    end
  end

  def destroy
    @chosen_item = @line_item.item
    @chosen_item.quantity += @line_item.quantity
    if @chosen_item.save && @line_item.destroy
      redirect_to cart_path(current_user.cart)
    else
      redirect_to cart_path(current_user.cart), alert: 'There was an issue removing the item from your cart.'
    end
  end

  def add_quantity
    @chosen_item = @line_item.item
    if @line_item.quantity < @chosen_item.quantity
      @line_item.quantity += 1
      @chosen_item.quantity -= 1
      if @line_item.save && @chosen_item.save
        redirect_to cart_path(current_user.cart)
      else
        redirect_to cart_path(current_user.cart), alert: 'There was an issue updating the item quantity.'
      end
    else
      redirect_to cart_path(current_user.cart), alert: 'This item is already at its maximum quantity in your cart.'
    end
  end

  def reduce_quantity
    if @line_item.quantity > 1
      @line_item.quantity -= 1
      @line_item.item.quantity += 1
      if @line_item.save && @line_item.item.save
        redirect_to cart_path(current_user.cart)
      else
        redirect_to cart_path(current_user.cart), alert: 'There was an issue updating the item quantity.'
      end
    else
      @line_item.destroy
      redirect_to cart_path(current_user.cart), notice: 'Item removed from cart.'
    end
  end

  private

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end
end
