class User < ApplicationRecord
    has_many :orders
    has_one :cart, dependent: :destroy
    has_secure_password

    after_create :create_cart_for_user

    private

    def create_cart
        Cart.create(user: self)
    end
end
