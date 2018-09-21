require 'rails_helper'

RSpec.describe 'Cart API', type: :request do
  let(:cart) { Cart.instance }
  let!(:products) { create_list(:product, 2) }

  describe 'POST /api/cart' do
    let(:valid_item) { { product_id: products.first.id, quantity: 2 } }
    let(:other_valid_item) { { product_id: products.second.id, quantity: 5 } }
    let(:invalid_item) { { product_id: products.first.id, quantity: 20 } }

    before { cart.add_product valid_item }

    context 'when the request is valid' do
      context 'when the product is new' do
        before { post '/api/cart', params: other_valid_item }

        it 'adds it to the cart' do
          expect(cart.cart_items.size).to eq 2
        end
      end

      context 'when the product is already exist' do
        before { post '/api/cart', params: valid_item }

        it 'increases its quantity' do
          expect(cart.cart_items.first[:quantity]).to eq(valid_item[:quantity] * 2)
        end

        it 'recalculates the sum' do
          expect(cart.cart_items.first[:sum]).to eq(cart.cart_items.first[:sum] * 2)
        end
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/cart', params: invalid_item }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns an error' do
        expect(json['error']).to include('params', 'type', 'message')
        expect(json['error']['type']).to eq "invalid_param_error" 
        expect(json['error']['message']).to eq "Invalid data parameters"
      end
    end
  end
end