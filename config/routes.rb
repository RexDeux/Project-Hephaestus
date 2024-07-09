Rails.application.routes.draw do
  root to: 'pages#home'

  # Pages routes
  get 'dashboard', to: 'pages#dashboard'

  # Cart routes
  resources :carts, only: [:show, :destroy]

  # Line item routes
  post 'line_items/:id/add', to: 'line_items#add_quantity', as: 'line_item_add'
  post 'line_items/:id/reduce', to: 'line_items#reduce_quantity', as: 'line_item_reduce'
  post 'line_items/:id/destroy', to: 'line_items#destroy', as: 'line_item_destroy'
  resources :line_items, only: [:create, :show, :destroy, :index]

  # Resourceful routes
  resources :items
  resources :orders, only: [:index, :show, :create, :new]
  resources :users
  
  # Session routes
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'  # Changed to POST for login action
  get '/logout', to: 'sessions#destroy'
end