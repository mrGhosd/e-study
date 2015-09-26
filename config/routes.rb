Rails.application.routes.default_url_options[:host] = 'http://localhost:3000' if Rails.env == "development"
Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks'}
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  get '/search', to: 'search#search'
  root to: "application#main"
  resources :users do
    post :generate_new_password_email, on: :collection
  end
  resources :images, only: :create
end
