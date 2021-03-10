Rails.application.routes.draw do
  devise_for :users
  # ログインと新規登録の時の指定

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get 'home/about' => "homes#about"
  post 'create/:id' => 'relationships#create', as:'follow'
  post 'destroy/:id' => 'relationships#destroy', as:'unfollow'
  get '/search' => 'search#search'
  resources :users, only: [:index, :show, :edit, :update]  do
    member do
      get :following, :followers
    end
  end
  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
end
