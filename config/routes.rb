Rails.application.routes.draw do
  root 'products#index'
  resources :products
  post '/checkout', to: 'checkout#create'
  resources :webhooks, only: :create
end
