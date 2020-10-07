Rails.application.routes.draw do

  root to: 'pages#home'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  post 'messages', to: 'messages#create'


  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Blazer::Engine, at: "blazer"
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :languages, only: :index, path: "/", param: :lang do
    member do
      resources :posts, only: :index, path: 'forum', as: :forum
      resources :posts, only: :new
      resources :messages, only: :index, path: 'chat', as: :chat
    end
  end

  get '/leaderboards', controller: 'pages', action: 'leaderboards'

  get '/notify_badges', controller: 'pages', action: 'notify_badges'

  post '/contact/send', controller: 'contact', action: 'send_message'

  resources :posts, only: [ :create, :show, :edit, :update ] do
    resources :comments, only: [:create, :destroy]
  end

  resources :messages, only: :create

  resources :users, only: :show

  resources :games, only: [ :show, :index ] do
    resources :plays, only: :create
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end


