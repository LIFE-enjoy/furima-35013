FactoryBot.define do
  factory :order_record_order do
    postal_code { '111-1111' }
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    city { Faker::Address.city }
    address { Faker::Address.street_address }
    phone_number { Faker::Number.number(digits: 11) }
    user_id { 1 }
    item_id { 1 }
  end
end
