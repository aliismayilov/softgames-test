Rails.application.routes.draw do
  root 'home#index'
  get 'picasa', to: 'home#picasa'
  resource :user, only: :show, defaults: { format: 'json' }
  resources :comments, only: :create, defaults: { format: 'json' }

  get '/auth/failure'            => 'sessions#failure',
    as: :auth_failure
  get '/auth/:provider'          => 'sessions#create',
    as: :login
  get '/auth/:provider/callback' => 'sessions#create',
    as: :auth_callback
  get '/logout'                  => 'sessions#destroy',
    as: :logout
end
