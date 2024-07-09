class User < ApplicationRecord
    has_many :orders
    has_one :cart, dependent: :destroy
    has_secure_password

    after_create :create_cart

    private

    def create_cart
        @user = User.new
        @user.save
        Cart.create(user: self)
    end
end
