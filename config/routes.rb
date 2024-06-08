# config/routes.rb
Rails.application.routes.draw do
  root to: 'homes#top'

  devise_for :users

  resources :books do
    collection do
      get :top_liked
    end
    resources :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :following, :followers
    end
  end

  resources :relationships, only: [:create, :destroy]

  resources :groups do
    member do
      post 'join'
      delete 'leave'
    end
  end

  get 'home/about', to: 'homes#about', as: 'about'
  get 'search', to: 'searches#search'
end
