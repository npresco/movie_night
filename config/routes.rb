Rails.application.routes.draw do
  root to: "users#new"

  get "/home" => "application#home"

  # Users
  get "users/new"  => "users#new", as: :new_user
  post "users"     => "users#create"

  # Login
  get "/login"     => "sessions#new"
  post "/login"    => "sessions#create"
  delete "/logout" => "sessions#destroy"

  resources :movies
end
