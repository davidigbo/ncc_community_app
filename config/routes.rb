Rails.application.routes.draw do
  # Devise routes for authentication
  devise_for :users

  # Admin namespace
  namespace :admin do
    resources :users
    resources :business_profiles
    resources :feedbacks, only: [:index, :show, :destroy]

    resources :events do
      resources :event_registrations, only: [:index, :show, :update, :destroy]
      resources :replies
    end

    # Admin dashboard root
    root to: "dashboard#index"
  end

  # User-specific routes (protected)
  authenticate :user do
    resources :dashboards, only: [:show]
    resources :profiles, only: [:show, :edit, :update]
    resource :settings, only: [:show, :update, :destroy]
  end

  # Public root page
  root "home#index"
end
