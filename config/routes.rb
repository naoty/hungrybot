Rails.application.routes.draw do
  post "/signup", to: "users#create"
  resources :users, only: [:show]
end
