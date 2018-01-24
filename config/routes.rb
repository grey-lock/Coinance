Rails.application.routes.draw do
  resources :coins
  resources :transactions
  resources :wallets
  root 'home#home'
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
end
