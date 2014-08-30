Rails.application.routes.draw do
  root 'home#index'

  get 'picasa', to: 'home#picasa'
end
