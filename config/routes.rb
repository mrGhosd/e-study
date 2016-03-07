if Rails.env == 'development'
  Rails.application.routes.default_url_options[:host] = 'http://localhost:3000'
end

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  namespace :api do

    namespace :v0 do

      resources :registrations, only: :create
      resource :sessions, only: [:create, :destroy] do
        get :current
      end

      get '/search', to: 'search#search'
      resources :users do
        collection do
          post :generate_new_password_email
          post :reset_password
        end
      end
      resources :images, only: :create
      resources :attaches, only: :create
      resources :chats
      resources :messages, only: :create

    end
  end
end
