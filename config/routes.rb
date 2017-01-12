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

  # Changes the receipt status = 2 (no longer editable and now splitable). Calls method in model to go through ListItems and create the guest items associated with the receipt. Will redirect to Guests#new.
  patch "receipts/:id/split", to: "receipts#split", as: "split_receipt"

  # Ge
  get "/receipts/guests/:id/split", to: "guests#split", as: "assign_to_guest"
  post "/receipts/guests/:id/", to: "guest_items#create", as: "post_guest_items"
end
