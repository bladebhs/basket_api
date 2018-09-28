module Api
  class CartController < ApplicationController
    # Disable parameter wrapping
    wrap_parameters format: []
    before_action :set_cart
    
    def index
      render json: @cart.to_json
    end

    def create
      cart_item = CartItem.new(cart_item_params)
      if cart_item.valid?
        @cart.add_product(cart_item)
        head :ok
      else
        errors = []
        cart_item.errors.each do |attribute, error|
          errors << {
            message: cart_item.errors.full_message(attribute, error),
            name: attribute
          }
        end
        render json: {
          error: {
            params: errors,
            type: "invalid_param_error",
            message: "Invalid data parameters"
          }
        }, status: 400
      end
    end

    def destroy
      if Product.exists?(params[:product_id])
        @cart.remove_product(params[:product_id])
        head :ok
      else
        render json: {
          error: {
            params: [{ message: "Product doesn't exist", name: "product_id" }],
            type: "invalid_param_error",
            message: "Invalid data parameters"
          }
        }, status: 400
      end
    end


    private

    def set_cart
      @cart = Cart.instance
    end

    def cart_item_params
      params.permit(:product_id, :quantity)
    end
  end
end