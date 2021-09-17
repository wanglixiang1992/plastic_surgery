Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :invoices, only: %i[index new create]
  resources :quickbooks do
    collection do
      get :authenticate
      get :oauth_callback
    end
    member do
      get :disconnect
    end
  end

  root to: 'invoices#index'
end
