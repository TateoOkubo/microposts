Rails.application.routes.draw do
  # get 'sessions/new'

  root to: 'static_pages#home'
  get     'signup', to: 'users#new'
  get     'login' , to: 'sessions#new'
  post    'login' , to: 'sessions#create'
  delete  'logout', to: 'sessions#destroy'
  
  # add
  post 'edit', to: 'users#edit'
  get 'edit' , to: 'users#edit'
  
  resources :users
  resources :microposts

  resources :relationships, only: [:create, :destroy]
  
  resources :favorites, only: [:create, :destroy]
  
  resources :users do
    member do
       get :followings, :followers, :favorites
    end
  end
  
  
  
  
end
