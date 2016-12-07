Rails.application.routes.draw do
  root 'statics_pages#home'
  get  '/help',    to: 'statics_pages#help'
  get  '/about',   to: 'statics_pages#about'
  get  '/contact', to: 'statics_pages#contact'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  resources :users
end