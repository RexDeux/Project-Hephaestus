class Item < ApplicationRecord
  has_one_attached :image
  validates :item_name, presence: true
end
