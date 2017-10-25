Rails.application.routes.draw do

  get 'helloworld/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'welcome', to: 'welcome#index'

  resources :articles do
    resources :comments
  end
end
