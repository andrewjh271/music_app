Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#new'

  resources :users, only: [:new, :create]
  resource :users, only: [:show, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :bands do
    resources :albums, only: [:new, :index]
  end
  resources :albums, except: :new
end
