Rails.application.routes.draw do

  get 'password_resets/create'

  get 'password_resets/edit'

  get 'password_resets/update'

  root 'houses#index'

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
    post :update_all, controller: "notifications"
  end

  resources :sessions, only: [:new, :create, :destroy]
  get 'login'   => 'sessions#new',    as: :login
  post 'logout' => 'sessions#destroy', as: :logout

  resources :conversations do
    resources :messages
  end

  get '/usernames' => 'mates#usernames'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

end
