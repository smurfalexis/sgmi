Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  get '/profile', to: 'pages#profile'
  get '/best_nfts', to: 'pages#best_nfts'
  get '/about', to: 'pages#about'
  get '/introduction', to: 'pages#introduction'
  get '/faq', to: 'pages#faq'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :wallets, only: [:show, :create, :new, :edit, :update]

  resources :nfts, only: %i[index show]

  resources :collections, only: %i[index show] do
    resources :watchlists, only: [:create]
    resources :watchlist_items, only: %i[create]
  end

  resources :watchlists, only: %i[show update destroy]
  resources :watchlist_items, only: %i[destroy]

  require 'sidekiq/web'
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
