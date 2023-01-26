class LineItem < ApplicationRecord
  belongs_to :item_name
  belongs_to :cart
  belongs_to :order

  #calculator
  def total_price
    self.quantity * self.item.total_price
  end
end
