Rails.application.routes.draw do
  get 'groups/new'
  get 'groups/index'
  get 'groups/show'
  get 'groups/edit'
  get 'relationships/followings'
  get 'relationships/followers'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "homes#top"
  get "home/about"=>"homes#about"
  devise_for :users
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
      get 'daily_search' => 'users#daily_search'
  end
  get "/search" => "searches#search"
  resources :chats, only: [:create, :show]
  resources :groups do
    get "join" => "groups#join"
    resources :event_notices, only: [:new, :create]
    get "event_notices" => "event_notices#sent"
  end
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end