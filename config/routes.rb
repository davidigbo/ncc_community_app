Rails.application.routes.draw do
  # Devise routes for user authentication
  devise_for :users

  # Admin namespace with authentication assumed in controllers
namespace :admin do
  resources :users
  resources :business_profiles

  resources :events do
    resources :feedbacks, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      resources :replies, only: [:index, :new, :create, :edit, :update, :destroy]
    end
    resources :event_registrations, only: [:index, :show, :update, :destroy]
  end

  root to: "dashboard#index"
end

  # Authenticated user routes
  authenticate :user do
    get '/dashboards', to: 'dashboards#show', as: :dashboard
    resources :profiles, only: [:show, :edit, :update]
    resource :settings, only: [:show, :update, :destroy]
  end

  # Public root page
  root "home#index"
end
