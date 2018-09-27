Rails.application.routes.draw do

  root to: "tasks#index"
  resources :tasks
  
  get "login", to:"sesstions#new"
  post "login", to:"sesstions#create"
  delete "logout", to:"sesstions#destroy"
  
  get "signup", to: "users#new"
  resources :users, only:[:new, :create]
end
