Rails.application.routes.draw do
  devise_for :users
  get '/search', to: 'search#search'
  root to: "application#main"
  resources :users
  resources :images, only: :create
end
