Rails.application.routes.draw do
  post "/signup", to: "users#create"
  resources :users, only: [:show] do
    resources :favorites, only: [:index, :create, :destroy]
  end
end
