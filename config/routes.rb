Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings'
    get 'followers' => 'relationships#followers'
  end
  post 'books/:id' => 'books#show'
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create,:destroy]
    patch '/book_comments' => 'book_comments#create'
  end
  resources :groups,except: [:destroy]
  get 'relationships/index'
  get 'search' => 'searches#search'
end