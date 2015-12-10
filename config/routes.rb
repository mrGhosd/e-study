Rails.application.routes.default_url_options[:host] = 'http://localhost:3000' if Rails.env == "development"
Rails.application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  namespace :api do
    resources :registrations, only: :create
    resource :sessions, only: [:create, :destroy] do
      get :current
    end

    namespace :v0 do

      get '/search', to: 'search#search'
      resources :users do
        collection do
          post :generate_new_password_email
          post :reset_password
        end

        member do
          resources :chats
        end
      end
      resources :images, only: :create

      resources :messages, only: :create

    end
  end
end
