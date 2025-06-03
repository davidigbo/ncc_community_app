Rails.application.routes.draw do
  devise_for :users

  root "home#index"

  namespace :admin do
    root "dashboard#index"
    resources :dashboard, only: :index
    resources :users
  end
  
  resources :profile, only: %i[show edit update]
end
