FactoryBot.define do
  factory :user do
    nickname {Faker::Name.last_name}
    email {Faker::Internet.free_email}
    password {Faker::Internet.password(min_length: 6, mix_case: true)}
    password_confirmation {password}
    last_name {Faker::Name.last_name}
    first_name {Faker::Name.first_name}
    last_name_kana {"ア"}
    first_name_kana {"ア"}
    birth_date {Faker::Date.between(from: '1930-01-01', to: '2016-12-31')}
  end
end
