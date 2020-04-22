Rails.application.routes.draw do
  resources :credit_cards
  root to: 'products#index'
 
  devise_for :users
 
  resources :products
  resources :charges
 
  mount StripeEvent::Engine, at: '/payments'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
