Rails.application.routes.draw do
  devise_for :users

 namespace :admin do
    resources :users
    resources :business_profiles
    resources :feedbacks, only: [:index, :show, :destroy]
    resources :events do
      resources :event_registrations, only: [:index, :show, :update, :destroy]
    end
    root to: "dashboard#index"
  end
  
  resources :profiles, only: [:show, :edit, :update]

  resources :dashboards, only: [:show]

  resource :settings, only: [:show, :update, :destroy]
  # resources :notifications, only: [:index, :destroy]

  root "home#index"
end
