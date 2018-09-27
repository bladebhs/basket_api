Rails.application.routes.draw do
  namespace :api do
    resources :products, only: :index
    resources :cart, only: [:index, :create, :destroy]
  end
end
