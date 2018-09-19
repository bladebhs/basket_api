class Cart
  include Singleton
  attr_accessor :cart_items

  def initialize
    @cart_items = []
  end

  # TODO
  def add_product(cart_item) end

  # TODO
  def remove_product(product_id) end
end