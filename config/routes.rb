Rails.application.routes.draw do
  root 'pages#home'
  get 'pages/about'
  get 'pages/course'
  get 'pages/otzuv'
  get 'signup', to: 'users#new'
  resources :microposts,          only: [:create, :destroy]
  resources :users
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
