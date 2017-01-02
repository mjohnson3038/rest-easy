Rails.application.routes.draw do
  root 'receipt#new'

  get 'receipt/new', to: 'receipt#new'

  get 'receipt/show', to: 'receipt/#show'

end
