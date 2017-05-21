Rails.application.routes.draw do
  get 'rates/create'

  get 'rates/destroy'

  get 'comments/create'

  get 'donations/index'

  root 'home#main'
  resources :categories
  resources :users do
    resources :projects, only: [:index]
    resources :donations, only: [:index]
  end
  resources :projects
  #get 'users/:id/projects',
  resource :session, only: [:new, :create, :destroy]
  resource :donations, only: [:create]
  resource :rates, only: [:create, :destroy]
  resource :comments, only: [:create]
  get '/buscar', to: 'home#search', as: 'search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
