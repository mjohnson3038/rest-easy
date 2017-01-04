Rails.application.routes.draw do
  root 'receipts#index'

  get "/auth/:provider/callback" => "sessions#create"

  resources :receipts, only: [:index, :new, :show, :create, :destroy]

end
