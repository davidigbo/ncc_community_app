Rails.application.routes.draw do
  namespace :admin do
    get "event_registrations/index"
    get "event_registrations/show"
    get "event_registrations/update"
    get "event_registrations/destroy"
    get "events/index"
    get "events/show"
    get "events/edit"
    get "events/update"
    get "events/destroy"
    get "feedbacks/index"
    get "feedbacks/show"
    get "feedbacks/destroy"
    get "business_profiles/index"
    get "business_profiles/show"
    get "business_profiles/edit"
    get "business_profiles/update"
    get "business_profiles/destroy"
    get "users/index"
    get "users/show"
    get "users/edit"
    get "users/update"
    get "users/destroy"
  end
  devise_for :users

 namespace :admin do
    resources :users, only: [:index, :edit, :update, :destroy]
    root to: "dashboard#index"
  end
  
   resources :profiles, only: [:show, :edit, :update] do
    member do
      post :vote
    end
  end
  resources :dashboards, only: [:show]

  resource :settings, only: [:show, :update, :destroy]
  # resources :notifications, only: [:index, :destroy]

  root "home#index"
end
