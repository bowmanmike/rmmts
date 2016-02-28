Rails.application.routes.draw do

  root 'houses#index'

  resources :houses do
    resources :chores, except: [:index]
    resources :announcements
  end

  resources :mates
  resources :sessions, only: [:new, :create, :destroy]
  get 'login'   => 'sessions#new',    as: :login
  post 'logout' => 'sessions#destroy', as: :logout

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

end
