class Cart
  include Singleton
  attr_accessor :cart_items

  def initialize
    @cart_items = []
  end

  def add_product(cart_item)
    if existing_item = cart_items.detect { |item| item.product_id == cart_item.product_id }
      existing_item.quantity += cart_item.quantity
      existing_item.calculate_sum
    else
      cart_items << cart_item
    end
  end

  def remove_product(product_id)
    found_item = cart_items.detect { |item| item.product_id == product_id }

    return unless found_item

    if found_item.quantity > 1
      found_item.quantity -= 1
      found_item.calculate_sum
    else
      cart_items.delete_if { |item| item.product_id == product_id }
    end
  end

  def size
    cart_items.size
  end

  def as_json(options = nil)
    {
      data: {
        total_sum: cart_items.map { |p| p.sum }.reduce(0, :+),
        products_count: size,
        products: cart_items
      }
    }
  end
end