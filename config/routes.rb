Rails.application.routes.draw do

  root 'houses#index'

  resources :password_resets

  resources :houses do
    resources :chores, except: [:index]
    resources :announcements
    resources :expenses, except: [:index] do
      resources :payments, except: [:index]
    end
  end

  resources :mates do
    resources :purchases, except: [:index] do
      resources :payments, except: [:index]
    end
    resources :notifications, only: [:update]
    member do
      get :activate
    end

    resources :points, only: [:index, :create, :update]
  end

  resources :sessions, only: [:new, :create, :destroy]
  get 'login'   => 'sessions#new',    as: :login
  post 'logout' => 'sessions#destroy', as: :logout

  resources :conversations do
    resources :messages
  end

  get '/usernames' => 'mates#usernames'
  get '/housenames' => 'houses#housenames'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

end
