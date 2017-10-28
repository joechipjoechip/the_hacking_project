Rails.application.routes.draw do

  root 'gossips#index'

  resources :mousaillons
  resources :gossips
  resources :comments


end
