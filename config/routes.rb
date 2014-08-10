Rails.application.routes.draw do

  root to: 'static_pages#home'
  devise_for :users
  
  get '/users/:id', to: 'users#show', as: :user

  resources :tips
  resources :bookmarks

  get '/new_user_registration', to: "users#new"
  get '/help', to: "static_pages#help"
  get '/about', to: "static_pages#about"

end
