class AddCartRefToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :cart, null: true, foreign_key: true
  end
end
