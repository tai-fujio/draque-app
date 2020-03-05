Rails.application.routes.draw do
  devise_for :users
  root to: 'games#index'
  get "/start", to: "games#start"
  resources :braves, only: :update
end
