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

  resources :clubs, only: [:index, :show, :new, :create, :destroy]
  resources :club_requests, only: [:create, :destroy, :update]
  resources :join_movie_to_users, only: [:show, :create, :update, :destroy]
  resources :lists, only: [:index, :show]
  resources :nominations, only: [:create, :update, :destroy]
  resources :movies
  resources :movie_trailers, only: [:show]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :polls, only: [:show]
  resources :viewings, only: [:create]
  resources :votes, only: [:create, :update]
end
