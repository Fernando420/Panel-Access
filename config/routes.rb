Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  # these routes are for showing users a login form, logging them in, and logging them out.
  resources :sessions do 
    collection do
      get '/login' => 'sessions#new'
      post '/login' => 'sessions#create'
      get :edit_password
      delete :logout
      get :forgot_password
      post :update_password
      post :email_forgot_pwd
    end
  end

  resources :clients do
    collection do
      get :access
      get :search_autocomplete
      post :access
      post 'access/create/:id' => 'clients#create_access'
    end
  end
  resources :payments do
    collection do
      get :add_client
    end
  end
  resources :users
  resources :type_products
  resources :products do
    collection do
      get 'barcode/:id' => 'products#get_by_barcode'
    end
  end
  resources :sales do
    collection do
      get 'download/ticket/:id' => 'sales#download_ticket'
    end
  end
  resources :reports do
    collection do
      get :add_client
    end
  end
end
