ContactDir::Application.routes.draw do

  devise_for :users, path_names: { sign_up: "register", sign_in: "login" } 
  devise_for :users

  root :to => "static_pages#home"

  resources :users, only: [:show, :index, :destroy]
  resources :groups

  match 'new_user' => 'users#new', as: :new_user, via: :get
  match 'create_user' => 'users#create', as: :create_user, via: :post

end