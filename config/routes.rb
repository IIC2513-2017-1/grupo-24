Rails.application.routes.draw do
  root 'home#main'
  resources :projects
  resources :categories
  resources :users
  get '/buscar/:search', to: 'home#search', as: 'search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
