Rails.application.routes.draw do
  namespace :admin do
    get '/', to: 'home#index'
    resources :categories
    resources :users
    resources :projects
  end
  root 'home#main'
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
  post '/buscar', to: 'home#category_filter', as: 'category_filter'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
