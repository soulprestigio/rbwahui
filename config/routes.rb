Rails.application.routes.draw do
  get "toyyibpay_webhooks/create"
  get "wallet_deposits/new"
  get "wallet_deposits/create"
  get "wallets/show"
  namespace :admin do
      resources :boards
      resources :synonyms
      resources :users
      resources :wahuiboards

      root to: "boards#index"
    end
  devise_for :users

  resource :wallet, only: [:show]
  resources :wallet_deposits, only: [:new, :create]
  post 'toyyibpay/webhook', to: 'toyyibpay_webhooks#create'

  resources :boards
  resources :synonyms
  resources :wahuiboards
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "homepage#index"
end
