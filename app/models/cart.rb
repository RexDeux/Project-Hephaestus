class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  has_many :items, through: :line_items
  belongs_to :user
  validates :user_id, presence: true

 def sub_total
    sum = 0
    self.line_items.each do |line_item|
      sum+= line_item.total_price
    end
    return sum
  end
end
