Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  get '/profile', to: 'pages#profile'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :wallets, only: [:show]
  resources :nfts, only: %i[index show]

  resources :collections, only: %i[index show] do
    resources :watchlists, only: [:create]
  end

  resources :watchlists, only: [:show, :update, :destroy]

  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
