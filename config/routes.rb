Rails.application.routes.draw do
  get 'relationships/index'
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followers_index' => 'relationships#followers_index'
    get 'followeds_index' => 'relationships#followeds_index'
  end
  post 'books/:id' => 'books#show'
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create,:destroy]
    patch '/book_comments' => 'book_comments#create'
  end
end