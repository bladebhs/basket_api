Product.delete_all
10.times do
  Product.create(
    name: Faker::Food.dish,
    description: Faker::Food.description,
    price: Faker::Number.between(100, 800)
  )
end
