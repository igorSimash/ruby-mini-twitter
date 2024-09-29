Rails.application.routes.draw do
  root "home#index"
  devise_for :users, only: [ :sessions, :registrations ]

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
