class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy]

  def home
  end


  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def edit
    authorize @item
  end

  def create
    @item = Item.new(item_params)
    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
       render :new
      end
    end
  end

  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def item_params
    params.require(:item).permit(:item_name, :price, :photo, :description, :quantity)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
