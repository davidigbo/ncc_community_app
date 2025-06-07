Rails.application.routes.draw do
  # Devise routes for authentication
  devise_for :users

  # Admin namespace
  namespace :admin do
    resources :users
    resources :business_profiles
    resources :feedbacks, only: [:index, :show, :new, :create, :destroy]

    resources :events do
      resources :event_registrations, only: [:index, :show, :update, :destroy]
      resources :replies
    end

    root to: "dashboard#index"
  end

  # User-specific routes (protected)
  authenticate :user do
    get '/dashboards', to: 'dashboards#show', as: :dashboard
    resources :profiles, only: [:show, :edit, :update]
    resource :settings, only: [:show, :update, :destroy]
  end

  # Public root page
  root "home#index"
end
