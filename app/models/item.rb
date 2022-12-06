class Item < ApplicationRecord
  include ImageUploader::Attachment(:image)
  has_one_attached :photo
  validates :item_name, presence: true
end
