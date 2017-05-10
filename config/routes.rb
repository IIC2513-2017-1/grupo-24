Rails.application.routes.draw do
  get 'donations/index'

  root 'home#main'
  resources :categories
  resources :users do
    resources :projects, only: [:index, :edit, :destroy]
    resources :donations, only: [:index]
  end
  resources :projects, only: [:index, :show]
  #get 'users/:id/projects',
  resource :session, only: [:new, :create, :destroy]
  get '/buscar/:search', to: 'home#search', as: 'search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
