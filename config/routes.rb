Rails.application.routes.draw do
  # get 'braves/update'
  devise_for :users
  root 'games#index'
  get '/start', to: 'games#start'
  get '/battle', to: 'games#battle'
  resources :braves, only: :update
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
