Rails.application.routes.draw do
  root 'mates#index'
  resources :mates
  resources :sessions, only: [:new, :create, :destroy]
  get 'login'   => 'sessions#new',    as: :login
  post 'logout' => 'sessions#destroy', as: :logout

end
