Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  get 'search' => 'searches#search'
  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'relationships/index'
    get 'followings' => 'relationships#followings'
    get 'followers' => 'relationships#followers'
  end
  resources :groups,except: [:destroy] do
    resources :group_users,only: [:index, :create, :destroy]
  end
  post 'books/:id' => 'books#show'
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create,:destroy]
    patch '/book_comments' => 'book_comments#create'
  end
end