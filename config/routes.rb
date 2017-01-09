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
  get '/list_items/new' => 'list_items#new'
  post 'list_items/new' => 'list_items#create'
  get '/list_items/:id/edit', to: 'list_items#edit', as: 'edit_list_item'
  patch '/list_items/:id/edit' => 'list_items#update'
  delete '/list_items/:id', to: 'list_items#destroy', as: 'delete_list_item'
  resources :list_items, only: [:new, :create, :edit, :update, :destroy]


end
