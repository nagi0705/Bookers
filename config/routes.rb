# config/routes.rb
Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :following, :followers
    end
  end

  resources :books do
    collection do
      get :top_liked
    end
    resources :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :groups do
    member do
      post 'join'
      delete 'leave'
    end
    resources :events, only: [:new, :create]
  end

  resources :relationships, only: [:create, :destroy]

  root 'homes#top'
  get 'home/about', to: 'homes#about', as: 'about'
  get 'search', to: 'searches#search'
end
