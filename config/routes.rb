if Rails.env == 'development'
  Rails.application.routes.default_url_options[:host] = 'http://localhost:3000'
end

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  namespace :api do

    namespace :v0 do

      resources :courses do
        resources :homeworks
      end
      resources :countries, only: :index
      resources :registrations, only: :create
      resource :sessions, only: [:create, :destroy] do
        get :current
        post :sms_code
      end

      get '/search', to: 'search#search'
      get '/search/chats', to: 'search#chats'
      get '/search/chats/:id', to: 'search#messages'

      post '/oauth/vkontakte', to: 'oauth#vk'

      resources :users do
        collection do
          post :generate_new_password_email
          post :reset_password
        end
      end
      resources :attaches, only: :create
      resource :notifications, only: :destroy
    end
  end
end
