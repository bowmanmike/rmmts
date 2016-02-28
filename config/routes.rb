Rails.application.routes.draw do

  get 'payments/new'

  get 'payments/create'

  get 'payments/show'

  get 'payments/edit'

  get 'payments/update'

  get 'payments/destroy'

  get 'expenses/new'

  get 'expenses/create'

  get 'expenses/show'

  get 'expenses/edit'

  get 'expenses/update'

  get 'expenses/destroy'

  root 'houses#index'

  resources :houses do
    resources :chores, except: [:index]
    resources :expenses, except: [:index] do
      resources :payments, except: [:index]
    end
  end

  resources :mates
  resources :sessions, only: [:new, :create, :destroy]
  get 'login'   => 'sessions#new',    as: :login
  post 'logout' => 'sessions#destroy', as: :logout

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

end
