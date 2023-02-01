Rails.application.routes.draw do
  root to: 'pages#home'
  get "dashboard", to: "pages#dashboard"

  get 'carts/:id' => "carts#show", as: "cart"
  delete 'carts/:id' => "carts#destroy"

  post 'line_items/:id/add' => "line_items#add_quantity", as: "line_item_add"
  post 'line_items/:id/reduce' => "line_items#reduce_quantity", as: "line_item_reduce"
  post 'line_items' => "line_items#create"
  get 'line_items/:id' => "line_items#show", as: "line_item"
  delete 'line_items/:id' => "line_items#destroy"

  resources :items
  resources :orders
  resources :users
  # Defines the root path route ("/")
  # root "articles#index"

  get '/login', to: 'sessions#login'
  get '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'

end
