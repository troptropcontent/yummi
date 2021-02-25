Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :meals, only: [:index, :show, :new, :create]
  resources :lines, only: [:create, :update]
  resources :orders, only: [:new, :show, :update]
  resources :reviews, only: [:create]
  get '/settings', to: 'pages#settings'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :meals, only: [ :index, :show, :update, :create, :destroy ]
    end
  end
end
