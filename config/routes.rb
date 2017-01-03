Rails.application.routes.draw do
  root 'receipts#index'

  resources :receipts, only: [:index, :new, :show, :create, :destroy]

end
