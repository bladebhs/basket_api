require 'rails_helper'

shared_context 'a valid request' do
  it 'returns status code 200' do
    expect(response).to have_http_status(200)
  end
end

shared_context 'an invalid request' do
  it 'returns status code 400' do
    expect(response).to have_http_status(400)
  end

  it 'returns an error' do
    expect(json['error']).to include('params', 'type', 'message')
    expect(json['error']['type']).to eq "invalid_param_error" 
    expect(json['error']['message']).to eq "Invalid data parameters"
  end
end

describe 'Cart API', type: :request do
  let(:cart) { Cart.instance }
  #let!(:products) { create_list(:product, 2) }
  #let(:valid_item) { { product_id: products.first.id, quantity: 2 } }
  #let(:invalid_item) { { product_id: products.first.id, quantity: 20 } }
  let(:valid_item) { attributes_for(:cart_item) }
  let(:invalid_item) { attributes_for(:cart_item, quantity: 20) }

  describe 'POST /api/cart' do
    context 'with valid parameters' do
      before { post '/api/cart', params: valid_item }

      it_behaves_like 'a valid request'
    end

    context 'with invalid parameters' do
      before { post '/api/cart', params: invalid_item }

      it_behaves_like 'an invalid request'
    end
  end

  describe 'DELETE /api/cart/:product_id' do
    context 'with valid product_id' do
      before { delete "/api/cart/#{products.first.id}" }

      it_behaves_like 'a valid request'
    end

    context 'with invalid product_id' do
      before { delete '/api/cart/90' }

      it_behaves_like 'an invalid request'
    end
  end

  describe 'GET /api/cart' do
    before { get '/api/cart' }

    it_behaves_like 'a valid request'
  end
end