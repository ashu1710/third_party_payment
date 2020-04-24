Rails.application.routes.draw do
  resources :credit_cards
 
  devise_for :users
 
  resources :products
  resources :charges
  get 'charges/:id/paypal_payment', to: 'charges#paypal_payment', as: 'paypal_payment'
  match '/paypal_action' => 'charges#paypal_action', via: [:get, :post], as: 'paypal_action'
  match '/payu_callback' => 'charges#payu_return', via: [:get, :post], as: 'payments_payu_return'

  mount StripeEvent::Engine, at: '/payments'
  root to: 'products#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
