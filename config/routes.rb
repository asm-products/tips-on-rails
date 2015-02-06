Rails.application.routes.draw do

  root to: 'static_pages#home'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end
  
  get '/users/:id', to: 'users#show', as: :user
  post '/tips/preview', to: 'tips#preview'

  resources :tips do
    post 'send_destroy_email', on: :member
  end

  get '/admin/dashboards', to: 'admin/dashboards#dashboards', as: :admin
  get '/admin/dashboards/index', to: 'admin/dashboards#index'
  get '/admin/dashboards/weekly_stats', to: 'admin/dashboards#weekly_stats'
 
  resources :bookmarks, only: [:create, :destroy]

  get '/new_user_registration', to: "users#new"
  get '/help', to: "static_pages#help"
  get '/about', to: "static_pages#about"

  # use this to test that the execptions are being properly emailed
  get 'test_exception_notifier', to: 'application#test_exception_notifier'

end
