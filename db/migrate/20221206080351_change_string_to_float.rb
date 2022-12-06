class ChangeStringToFloat < ActiveRecord::Migration[7.0]
  def change
    change_column :items, :price, :float, using: 'price::float'
    change_column :items, :quantity, :integer, using: 'quantity::integer'
  end
end
