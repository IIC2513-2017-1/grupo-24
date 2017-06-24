Rails.application.routes.draw do
  namespace :admin do
    get '/', to: 'projects#index'
    resources :categories, except: [:show]
    resources :users, except: [:new, :create, :show]
    resources :projects, except: [:show]
  end
  root 'home#main'
  resources :users do
    get 'create_token', to: 'users#create_token', as: 'create_token'
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
  get '/users/:id/change_password', to: 'users#change_password', as: 'edit_password'
  post '/users/:id/change_password', to: 'users#edit_password', as: 'change_password'

  namespace :api do
    namespace :v1 do
      resources :projects, except: [:new, :edit]
      resources :users, only: [:show]
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
