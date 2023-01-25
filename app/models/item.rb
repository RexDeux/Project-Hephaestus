class Item < ApplicationRecord
  has_one_attached :image
  has_many :line_items, dependent: :destroy
  validates :item_name, presence: true
end
