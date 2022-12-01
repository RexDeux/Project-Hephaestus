Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  #root to: 'items#index'
  root to: 'pages#home'
  get "dashboard", to: "pages#dashboard"
  resources :items
  # Defines the root path route ("/")
  # root "articles#index"
end
