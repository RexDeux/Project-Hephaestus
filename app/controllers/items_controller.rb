class ItemsController < ApplicationController

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
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(item_params)
    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'O item foi criado com sucesso.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { redirect_to new_item_path, notice: 'Por favor preencha os campos vazios' }
      end
    end
  end

  def update
    @item = Item.find(params[:id])
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'O item foi actualizado.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'O item foi destruído.' }
      format.json { head :no_content }
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :price, :image, :description, :quantity)
  end
end
