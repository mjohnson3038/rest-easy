Rails.application.routes.draw do
  root 'mains#index'

  # OmniAuth
  get "/auth/:provider/callback" => "sessions#create"

  get "/sessions/login_failure", to: "sessions#login_failure", as: "login_failure"
  get "/sessions", to: "sessions#index", as: "sessions"
  delete "/sessions", to: "sessions#destroy"

  # RECEIPT
  resources :receipts, only: [:index, :new, :show, :create, :destroy]

  # ListItem
  resources :list_items, only: [:new, :create, :edit, :update, :destroy]


end
