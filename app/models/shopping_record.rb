class ShoppingRecord < ApplicationRecord

  belongs_to :user
  has_one :shopping_information, dependent: :destroy
  belongs_to :item
end
