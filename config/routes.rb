Rails.application.routes.draw do
  root "static_pages#home"

  resources :users, except: :new
  get "signup", to: "users#new"

  get "help", to: "static_pages#help"
  get "about", to: "static_pages#about"
  get "contact_us", to: "static_pages#contact_us"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
