class ShoppingRecordForm
  include ActiveModel::Model

  attr_accessor :postal_code, :prefecture_id, :municipality, :street_address,
                :building_name, :phone_number, :item_id, :user_id, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :municipality
    validates :street_address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "is invalid" }
    validates :user_id
    validates :item_id
    validates :token, presence: { message: "を入力してください" } 
  end

  def save
    shopping_record = ShoppingRecord.create(user_id: user_id, item_id: item_id)
    ShoppingInformation.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      municipality: municipality,
      street_address: street_address,
      building_name: building_name,
      phone_number: phone_number,
      shopping_record_id: shopping_record.id
    )
  end
end