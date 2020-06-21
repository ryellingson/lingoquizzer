Rails.application.routes.draw do

  post 'messages', to: 'messages#create'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root to: 'pages#home'

  resources :languages, only: :index, path: "/", param: :lang do
    member do
      resources :posts, only: :index, path: 'forum', as: :forum
      resources :posts, only: :new
      resources :messages, only: :index, path: 'chat', as: :chat
    end
  end

  get '/leaderboards', controller: 'pages', action: 'leaderboards'

  post '/contact/send', controller: 'contact', action: 'send_message'

  resources :posts, only: [ :create, :show ] do
    resources :comments, only: [:new, :create, :show, :destroy]
  end

  resources :messages, only: :create

  resources :users, only: :show

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


