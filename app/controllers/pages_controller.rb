class PagesController < ApplicationController

  def home
  end

  def dashboard
    # Example of fetching items, replace with your own logic
    @items = Item.all  # Fetch all items or filter based on your requirements

    # Render the dashboard view
    # Adjust the path to your actual dashboard view file
    render 'dashboard'
  end
end
