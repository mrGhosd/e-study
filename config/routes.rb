Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks'}
  get '/search', to: 'search#search'
  root to: "application#main"
  resources :users
  resources :images, only: :create
end
