FactoryBot.define do
  factory :shopping_record_form do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    municipality { '東京都' }
    street_address { '1-1' }
    building_name { '東京ハイツ' }
    phone_number { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }

    association :user
    association :item
  end
end