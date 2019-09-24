Rails.application.routes.draw do
  root to: "application#home"

  # Users
  get "users/new"  => "users#new", as: :new_user
  post "users"     => "users#create"

  # Login
  get "/login"     => "sessions#new"
  post "/login"    => "sessions#create"
  post "/session"  => "sessions#update"
  delete "/logout" => "sessions#destroy"

  resources :movies
  resources :watchlists, only: [:show, :create, :destroy]
  resources :seenlists, only: [:show, :create, :update, :destroy]
  resources :lists, only: [:index, :show]
  resources :clubs, only: [:index, :show, :new, :create, :destroy]
  resources :club_requests, only: [:create, :destroy, :update]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :viewings, only: [:create]
  resources :nominations, only: [:create, :update, :destroy]
  resources :polls, only: [:show]
  resources :movie_trailers, only: [:show]
  resources :votes, only: [:create, :update]
end
