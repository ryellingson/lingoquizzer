Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get '/games-menu', controller: 'pages', action: 'index'

  get '/forum', controller: 'pages', action: 'forum'

  resources :games, only: :show
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
