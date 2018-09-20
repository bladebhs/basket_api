FactoryBot.define do
  factory :cart_item do
    product_id { create(:product).id }
    quantity { Faker::Number.between(1, 10) }
  end
end