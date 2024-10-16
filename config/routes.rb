Rails.application.routes.draw do
  authenticated :user do
    root "tweets#index", as: :authenticated_root
  end

  unauthenticated :user do
    root "home#index", as: :unauthenticated_root
  end

  devise_for :users, only: [ :sessions, :registrations ]

  resources :tweets

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
