Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#homepage'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :meals, only: [:index, :show, :new, :create]
  resources :lines, only: [:create, :update]
  resources :orders, only: [:new, :show, :update] do
  resources :reviews, only: [ :new, :create ]
  end
  get '/settings', to: 'pages#settings'
  get '/home', to: 'pages#home'
  get '/dashboard', to: 'pages#dashboard'

  resources :charges, only: [:new, :create]


  resources :chatrooms, only: :show do
    resources :messages, only: [ :new, :create ]
  end


  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :meals, only: [ :index, :show, :update, :create, :destroy ]
    end
  end
end
