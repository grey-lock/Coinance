Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :coins
  
  # Use nested resource so only current_user can view their wallets, transactions
  resources :users, only: [:show] do
    resources :wallets
    resources :transactions
  end
  
  root 'home#home'
  
  get '/coins/most_transactions' => 'coins#show'
 
  
end
