Rails.application.routes.draw do
  devise_for :users
  root to: 'games#index'
  get "/start", to: "games#start"
  get "/battle", to: "games#battle"
  # 上二つresourcesに存在するアクションとは別のオリジナル
  resources :braves, only: :update
end
