Rails.application.routes.default_url_options[:host] = 'http://localhost:3000' if Rails.env == "development"
Rails.application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  namespace :api do
    resources :registrations, only: :create
    resources :sessions, only: [:create, :destroy]
    namespace :v0 do

      get '/search', to: 'search#search'
      root to: "application#main"
      resources :users do
        collection do
          post :generate_new_password_email
          post :reset_password
        end
      end
      resources :images, only: :create
      resources :chats
      resources :messages, only: :create

    end
  end
end
