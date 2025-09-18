FactoryBot.define do
  factory :item do
    association :user
    item_name { "テスト商品" }
    item_information { "これはテストの商品です" }
    item_type_id { 2 }
    item_condition_id { 2 }
    shipping_cost_id { 2 }
    prefecture_id { 2 }
    days_to_ship_id { 2 }
    price { 1000 }

    after(:build) do |item|
      item.image.attach(
        io: File.open(Rails.root.join('spec/fixtures/files/test_image.png')),
        filename: 'test_image.png',
        content_type: 'image/png'
      )
    end
  end
end