require 'rails_helper'

describe ApplicationController, type: :request do
  context 'when route not found' do
    before { get '/api/cart/info' }

    it 'returns status code 404' do
      expect(response).to have_http_status(404)
    end

    it 'returns an error' do
      expect(json['error']).to eq(
        {
          "type"=>"invalid_request_error",
          "message"=>"Unable to resolve the request \"api/cart/info\"."
        }
      )
    end
  end
end