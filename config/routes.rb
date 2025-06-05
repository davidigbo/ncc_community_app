Rails.application.routes.draw do
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

  root "home#index"
end
