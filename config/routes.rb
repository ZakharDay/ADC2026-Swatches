Rails.application.routes.draw do
  namespace :api, format: "json" do
    namespace :v1 do
      get "welcome/index"
      get "welcome/about"
    end
  end

  resources :subscriptions, only: :create

  namespace :admin do
    resources :subscriptions, only: :index

    resources :projects
    resources :swatches
    resources :fills
    resources :colors

    root "home#index"
  end

  devise_for :users
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  get "welcome/about"
  root "welcome#index"
end
