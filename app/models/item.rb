class Item < ApplicationRecord
  has_one_attached :image
  has_many :line_items, dependent: :destroy
  has_many :orders, through: :line_itemss
  validates :item_name, presence: true
  validates_presence_of :item_name, :description, :price, :quantity, :image
end
