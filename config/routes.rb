Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'bands#index'

  resources :users, only: [:new, :create]
  resource :users, only: [:show, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :bands do
    resources :albums, only: [:new, :index]
  end
  resources :albums, except: :new do
    resources :tracks, only: [:new, :index]
  end
  resources :tracks, except: [:new, :index]
  resources :notes, only: [:create, :destroy]
end
