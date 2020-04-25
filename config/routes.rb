Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get '/forum', controller: 'pages', action: 'forum'

  get '/user_profile', controller: 'pages', action: 'user_profile'

  resources :games, only: [ :show, :index ] do
    resources :plays, only: :create
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
