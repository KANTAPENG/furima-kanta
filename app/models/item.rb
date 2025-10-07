class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :item_type
  belongs_to :item_condition
  has_one_attached :image
  belongs_to :shipping_cost
  belongs_to :prefecture
  belongs_to :days_to_ship
  has_one :shopping_record

  validates :item_name, presence: true
  validates :item_information, presence: true
  validates :image, presence: true

  validates :price, presence: true,
                  numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  validates :item_type_id, :item_condition_id, :shipping_cost_id, :prefecture_id, :days_to_ship_id,
            numericality: { other_than: 1 , message: "can't be blank"} 
end