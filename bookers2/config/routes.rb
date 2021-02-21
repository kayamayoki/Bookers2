Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  root to: "home#top"
  get "home/about" => "home#about"
  resources :books, only: [:create,:edit,:update,:index,:show,:destroy]
  resources :users, only: [:show,:edit,:update,:index]
end
