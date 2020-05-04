Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root to: 'pages#home'

  get '/forum', controller: 'pages', action: 'forum'

  post '/contact/send', controller: 'contact', action: 'send_message'

  resources :users, only: [ :show ]

  resources :games, only: [ :show, :index ] do
    resources :plays, only: :create
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
