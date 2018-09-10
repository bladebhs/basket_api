class ProductSerializer < ActiveModel::Serializer
  type :data
  attributes :id, :name, :description, :price
end
