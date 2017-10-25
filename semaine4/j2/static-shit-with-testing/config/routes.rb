Rails.application.routes.draw do
  root 'static_pages#index'

  get 'static_pages/index'
  get 'static_pages/about'
  get 'static_pages/contact'
  get 'static_pages/help'

  get '/home', to: 'static_pages#index'
  get '/contact', to: 'static_pages#contact'
  get '/about', to: 'static_pages#about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
