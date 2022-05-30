Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  get "/profile", to: "pages#profile"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :wallets, only: [:show]
  resources :nfts, only: [:index, :show]

  resources :collections, only: [:index, :show] do
    resources :watchlists, only: [:create]
  end

  resources :watchlists, only: [:show, :update, :destroy]

end
