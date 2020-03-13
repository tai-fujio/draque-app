Rails.application.routes.draw do
  devise_for :users
  root to: 'games#index'
  get "/start", to: "games#start"
  get "/battle", to: "games#battle"
  get "/exit", to: "games#exit"
  get "/skill", to: "games#skill"
  get "/spell", to: "games#spell"

  # resources :games, only: :update
  resources :braves, only: :update


end
