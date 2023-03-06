Rails.application.routes.draw do
  root 'products#index'
  resources :products
  post '/checkout', to: 'checkout#create'
end
