class ShoppingRecord < ApplicationRecord

  belongs_to :user
  has_one :shopping_information
  belongs_to :item
end
