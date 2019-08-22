Rails.application.routes.draw do
  root to: "application#home"

  # get "/home" => "application#home"

  # Users
  get "users/new"  => "users#new", as: :new_user
  post "users"     => "users#create"

  # Login
  get "/login"     => "sessions#new"
  post "/login"    => "sessions#create"
  post "/session"  => "sessions#update"
  delete "/logout" => "sessions#destroy"

  resources :movies
  resources :watchlists, only: [:index, :show, :create, :destroy]
  resources :lists, only: [:index, :show]
  resources :clubs, only: [:index, :show, :new, :create, :destroy]
  resources :club_requests, only: [:create, :destroy, :update]
  resources :viewings, only: [:create]
  resources :nominations, only: [:create, :update]
  resources :polls, only: [:show]
  resources :votes, only: [:create, :update]
end
