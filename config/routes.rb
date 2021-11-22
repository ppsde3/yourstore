Rails.application.routes.draw do
  root to: 'products#index'

  resources :products, only: [:index, :show]
  resources :categories, only: [:show]
  resources :orders, only: [:create, :show]

  resource :cart, only: [:show] do
    put    :add_item
    delete :remove_item
  end

  namespace :admin do
    root to: 'dashboard#show'
    resources :products, except: [:edit, :update, :show]
    resources :categories, only: [:new, :index, :create]
  end

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  
end
