FactoryBot.define do
  factory :order_record_order do
    postal_code { '111-1111' }
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    city { Faker::Address.city }
    address { Faker::Address.street_address }
    building { Faker::Lorem.word }
    phone_number { Faker::Number.number(digits: 11) }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
