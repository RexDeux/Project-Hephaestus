class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :item_name
      t.string :price
      t.string :image_url
      t.string :description
      t.string :quantity

      t.timestamps
    end
  end
end
