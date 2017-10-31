Rails.application.routes.draw do

  root 'users#index'

  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new', as: 'login_path'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
