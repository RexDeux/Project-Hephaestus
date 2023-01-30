module LineItemsHelper

   #calculator
  def total_price
    self.quantity * self.item.total_price
  end
end
