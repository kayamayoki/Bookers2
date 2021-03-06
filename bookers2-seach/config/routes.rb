Rails.application.routes.draw do
  get 'search/search'
  root to: 'homes#top'
  get 'home/about' => 'homes#about'

  devise_for :users

  get 'users/:user_id/follows' => 'relationships#follows', as: 'follows'
  get 'users/:user_id/followers' => 'relationships#followers', as: 'followers'
  get '/search' => 'search#search'

  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:destroy, :create]
  end
  resources :books do
  resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
end