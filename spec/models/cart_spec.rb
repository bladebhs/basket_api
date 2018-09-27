require 'rails_helper'

describe Cart do
  let(:cart) { Cart.instance }
  let!(:products) { create_list(:product, 2) }
  let(:first_item) { CartItem.new(product_id: products.first.id, quantity: 1) }
  let(:second_item) { CartItem.new(product_id: products.second.id, quantity: 2) }

  before do
    cart.cart_items.clear
    cart.add_product(first_item)
  end

  context 'when adding an existing product' do
    let(:new_item) { CartItem.new(product_id: products.first.id, quantity: 6) }

    before { cart.add_product(new_item) }

    it 'increases its quantity' do
      expect(cart.cart_items.first.quantity).to eq 7
    end

    it 'recalculates the sum' do
      price = Product.find(products.first.id).price
      expect(cart.cart_items.first.sum).to eq(price * 7)
    end
  end

  context 'when adding a new product' do
    it 'adds an item' do
      expect { cart.add_product(second_item) }.to change { cart.size }.by(1)
    end
  end

  context 'when deleting a product' do
    context 'if its quantity equals to one' do
      it 'removes an item' do
        expect { cart.remove_product(products.first.id) }.to change { cart.size }.by(-1)
      end
    end

    context 'if its quantity is greater than one' do
      before { cart.add_product(first_item) }

      it 'decreases quantity' do
        expect { cart.remove_product(products.first.id) }.to change { cart.cart_items.first.quantity }.by(-1)
      end
    end
  end

  describe '.to_json' do
    it 'returns proper JSON structure' do
      cart.add_product(second_item)
      expect(cart.to_json).to eq(
        {
          data: {
            total_sum: first_item.sum + second_item.sum,
            products_count: 2,
            products: [
              {
                id: first_item.product_id,
                quantity: 1,
                sum: first_item.sum
              },
              {
                id: second_item.product_id,
                quantity: 2,
                sum: second_item.sum
              }
            ]
          }
        }.to_json
      )
    end
  end
end