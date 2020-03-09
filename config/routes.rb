Rails.application.routes.draw do
  devise_for :users
  root to: 'games#index'
  get "/start", to: "games#start"
  get "/battle", to: "games#battle"
  get "/exit", to: "games#exit"
  # 上3つresourcesに存在するアクションとは別のオリジナル
  resources :braves, only: :update
end
