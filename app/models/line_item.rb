class LineItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :cart
  belongs_to :order, optional: true

  validates :item_id, presence: true
  validates :cart_id, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 1 }
  
  #calculator
  def total_price
    self.quantity * self.item.price
  end
end
