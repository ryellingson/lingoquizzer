Rails.application.routes.draw do

  post 'messages', to: 'messages#create'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root to: 'pages#home'

  get '/chillspace/forum', controller: 'pages', action: 'chillspace', as: :forum

  get '/chillspace/chat', controller: 'pages', action: 'chillspace', as: :chat

  post '/contact/send', controller: 'contact', action: 'send_message'

  resources :posts do
    resources :comments, only: [:create, :show, :destroy]
  end

  resources :messages, only: [ :new, :create ]

  resources :users, only: [ :show ]

  resources :games, only: [ :show, :index ] do
    resources :plays, only: :create
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
