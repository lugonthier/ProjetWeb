Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'coaches#new'

  get '/profil', to: 'coaches#edit', as: :profil

  patch '/profil', to: 'coaches#update'


  get '/login', to: 'sessions#new', as: :new_session

  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy', as: :destroy_session

  
  resources :coaches, only: [:new, :create, :edit] do
    member do
      get 'confirm'
    end
  end

end
