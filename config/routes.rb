Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")

  root "chat#index"
  get "chats/", to: "chat#index"
  devise_for :users
  resources :api_tokens

  resources :chat, only: [ :index, :show ] do
    member do
      get :check_updates
    end
  end

  resources :conversation_statuses do
    member do
      patch :update_status
    end
  end

  namespace :api do
    namespace :v1 do
      defaults format: :json do
        get "home/index", to: "home#index"
        get "products", to: "products#index"
        get "products/cut_prise", to: "products#cut_prise"
        get "products/size", to: "products#size"
      end
    end
  end
end
