FactoryBot.define do
  factory :form do
    postal_code     { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture_id   { rand(2..48) }
    city            { Gimei.city.kanji }
    street_address  { Faker::Address.street_address }
    building_name   { Faker::Address.secondary_address }
    phone_number    { Faker::Number.number(digits: 10) }
    order_id        { Faker::Number.number(digits: 2) }
    token           { Faker::Alphanumeric.alphanumeric(number: 20)}
  end
end
