class PagesController < ApplicationController

  def home
  end

  def dashboard
    @items = Item.all
  end
end
