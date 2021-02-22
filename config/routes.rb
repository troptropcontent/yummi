Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :meals, only: [:index, :show, :new, :create]
  resources :lines, only: [:create]
  resources :orders, only: [:show, :update]
  resources :reviews, only: [:create]
  get '/settings', to: 'pages#settings'

end
