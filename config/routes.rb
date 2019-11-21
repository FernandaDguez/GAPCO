Rails.application.routes.draw do

  
  devise_for :users#, :skip => [:registrations]

  devise_scope :user do
    resources :users
    get 'login', to: 'devise/sessions#new'
    get 'edit', to: 'devise/registrations#edit', as: :edit_myaccount
    delete 'logout', to: 'devise/sessions#destroy'
    get 'users/new', to: 'users#new', as: :sign_up
    post 'users/new', to: 'users#create'
    get 'users', to: 'users#index', as: :index
    patch "users/:id", to: "users#update"
    post 'users/:id/edit', to: 'users#update'
  end



  authenticated :user do
    resources :areas
    resources :recommendations, except: :index do
      resources :goals
    end
    resources :goals
    resources :alerts

    resources :evidences, except: :index
    resources :evidencefiles, only: [:create, :destroy]
    # Routes for authenticated users
    root to: 'areas#index', as: :authenticated_root
    #get "/areas", to: 'areas#index'
  end

  unauthenticated :user do
    get "/areas", to: redirect('login')
  end
  root to: redirect('login')


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
