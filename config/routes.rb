# TODO - change accessibility via status and user_id.
# TODO Error handling, for EVERYTHING (phone number, etc)
# TODO - get avalara to work
# TODO - tip calculator - built in to say the percentage - AJAX ?? - DO NOT WANT TO HAVE TO REFReSH.
# TODO - talk to someone about the routes - especially the AJAX routes.


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
    resources :guests, only: [:index, :new, :create, :show, :update] do

      resources :guest_items, only: [:index]
    end
  end

  get "receipts/:receipt_id/finalize", to: "receipts#finalize", as: "finalize_receipt"

  # TO HANDLE AJAX of creating new guest
  post "receipts/:receipt_id/guests/", to: "guest_items#create_guest", as: "AJAX_create_guest"

  post "/guests/:guest_id/guest_items/", to: "guest_items#update", as: "update_guest_items"

  # Page where user can select the tip and view the total for their order
  get "guests/:guest_id/tip", to: "guests#tip", as: "guests_tip"
  post "guests/:guest_id ", to: "guests#add_tip", as: "guests_tip_add"


  # get "/receipts/guests/:id/split", to: "guests#split", as: "split_receipt"
  # post "/receipts/guests/:id/", to: "guest_items#create", as: "post_guest_items"
end
