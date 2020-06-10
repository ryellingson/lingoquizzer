Rails.application.routes.draw do

  post 'messages', to: 'messages#create'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root to: 'pages#home'

  get '/conversations/forum', controller: 'pages', action: 'conversations', as: :forum

  get '/conversations/chat', controller: 'pages', action: 'conversations', as: :chat

  get '/leaderboards', controller: 'pages', action: 'leaderboards'

  post '/contact/send', controller: 'contact', action: 'send_message'

  resources :posts do
    resources :comments, only: [:create, :show, :destroy]
  end

  resources :messages, only: [ :new, :create ]

  resources :users, only: [ :show ]

  resources :games, only: [ :show, :index ] do
    resources :plays, only: :create
  end

  namespace :admin do
    resources :games

    get '/home', controller: 'pages', action: 'home'

    get '/game_home', controller: 'pages', action: 'game_home'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end


