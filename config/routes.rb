Rails.application.routes.draw do
  namespace :api do
    resources :products, only: :index
    resources :cart, only: [:index, :create]
    delete 'cart/:product_id', to: 'cart#destroy', as: :cart
  end
  match '*unmatched_route', to: 'application#not_found', via: :all
end
