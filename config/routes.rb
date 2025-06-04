Rails.application.routes.draw do
  get "inertia-example", to: "inertia_example#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")

  scope module: :v1 do
    get "/posts", to: "post#index"
    root "home#index"
    namespace :identity do
      resource :email,              only: [:edit, :update]
      resource :email_verification, only: [:show, :create]
      resource :password_reset,     only: [:new, :edit, :create, :update]
    end
    scope module: :auth do
      get  "sign_in", to: "sessions#new"
      post "sign_in", to: "sessions#create"
      get  "sign_up", to: "registrations#new"
      post "sign_up", to: "registrations#create"
      resources :sessions, only: [:index, :show, :destroy]
      resource  :password, only: [:edit, :update]
    end
  end
end
