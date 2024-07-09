class Order < ApplicationRecord
  belongs_to :user
  has_many :line_items, dependent: :destroy
  has_many :items, through: :order_items
end
