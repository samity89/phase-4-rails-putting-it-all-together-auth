Rails.application.routes.draw do
  resources :recipes, only: [:index, :create]
  resources :users, only: [:create, :show]
  post "/signup", to: "users#create"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/me", to: "users#show"
  get "/recipes", to: "recipes#index"
end
