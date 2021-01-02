Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/create'
  get 'password_resets/edit'
  get 'password_resets/update'
  root "static_pages#home"

  resources :users, except: :new
  resources :account_activations, only: :edit, param: :activation_token

  get "signup", to: "users#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  get "help", to: "static_pages#help"
  get "about", to: "static_pages#about"
  get "contact_us", to: "static_pages#contact_us"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
