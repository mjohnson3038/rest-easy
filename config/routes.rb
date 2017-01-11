Rails.application.routes.draw do
  root 'mains#index'

  # OmniAuth
  get "/auth/:provider/callback" => "sessions#create"

  get "/sessions/login_failure", to: "sessions#login_failure", as: "login_failure"
  get "/sessions", to: "sessions#index", as: "sessions"
  delete "/sessions", to: "sessions#destroy"

  # RECEIPT
  resources :receipts, only: [:index, :new, :show, :create, :destroy] do
    # ListItems
    resources :list_items, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :guests, only: [:index, :new, :create, :show]
  end

  get "/receipts/guests/:id/split", to: "guests#split", as: "split_receipt"
end
