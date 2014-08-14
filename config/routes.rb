Rails.application.routes.draw do

  root to: 'static_pages#home'
  devise_for :users
  
  get '/users/:id', to: 'users#show', as: :user

  resources :tips do
    post 'send_destroy_email', on: :member
  end

  resources :bookmarks

  get '/new_user_registration', to: "users#new"
  get '/help', to: "static_pages#help"
  get '/about', to: "static_pages#about"

  # use this to test that the execptions are being properly emailed
  get 'test_exception_notifier', to: 'application#test_exception_notifier'

end
