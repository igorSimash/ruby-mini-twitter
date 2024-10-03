Rails.application.routes.draw do
  devise_scope :user do
    authenticated :user do
      root "devise/registrations#edit", as: :authenticated_root # TODO: Change after creating tweets#index
    end
  end

  unauthenticated :user do
    root "home#index", as: :unauthenticated_root
  end

  devise_for :users, only: [ :sessions, :registrations ]

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
