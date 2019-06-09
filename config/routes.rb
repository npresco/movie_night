Rails.application.routes.draw do
  root to: "users#new"

  # Users
  get "users/new"  => "users#new", as: :new_user
  post "users"     => "users#create"

  # Login
  get "/login"     => "sessions#new"
  post "/login"    => "sessions#create"
  delete "/logout" => "sessions#destroy"
end
