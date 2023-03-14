Rails.application.routes.draw do
  devise_for :users
  root 'products#index'
  resources :products
  post '/checkout', to: 'checkout#create'
  resources :webhooks, only: :create
  get '/success', to: 'checkout#success'
  get '/cancel', to: 'checkout#cancel'
end
