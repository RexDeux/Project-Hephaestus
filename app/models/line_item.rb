class LineItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :cart
  belongs_to :order

  #calculator
  def total_price
    self.quantity * self.item.price
  end
end
