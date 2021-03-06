Rails.application.routes.draw do
  root "static_pages#home"

  resources :users, except: :new do
    get :following, :followers, on: :member
  end
  resources :relationships, only: %i[create destroy]

  resources :account_activations, only: :edit, param: :activation_token
  resources :password_resets, except: %i[destroy show index], param: :reset_token
  resources :chirps, only: %i[create destroy]

  get "signup", to: "users#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  get "help", to: "static_pages#help"
  get "about", to: "static_pages#about"
  get "contact_us", to: "static_pages#contact_us"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
