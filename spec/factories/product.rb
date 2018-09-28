FactoryBot.define do
  factory :product do
    name { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
    price { Faker::Number.between(100, 800) }
  end
end