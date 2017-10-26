Rails.application.routes.draw do

  root 'static_pages#index'

  get 'static_pages/index', to: 'static_pages#index'

  get '/index', to: 'static_pages#index'
  get '/about(/:name)', to: 'static_pages#about'

  resources :users

end
