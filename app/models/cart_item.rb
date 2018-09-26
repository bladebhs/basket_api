class CartItem
  include ActiveModel::Model

  # Attributes
  attr_accessor :product_id, :quantity
  attr_reader :sum

  # Validations
  validates_presence_of :product_id, :quantity
  validates_numericality_of :product_id, only_integer: true
  validates_numericality_of :quantity,
                            only_integer: true,
                            greater_than_or_equal_to: 1,
                            less_than_or_equal_to: 10
  validate :product_exists


  def initialize(attributes = {})
    super
    calculate_sum
  end

  def calculate_sum
    @sum = Product.find(@product_id).price * @quantity rescue 0
  end


  private

  def product_exists
    unless Product.exists?(product_id)
      errors.add(:product_id, "doesn't exist")
    end
  end
end