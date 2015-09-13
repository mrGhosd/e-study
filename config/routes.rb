Rails.application.routes.draw do
  devise_for :users
  root to: "application#main"
  resources :users
  resources :images, only: :create
end
