# frozen_string_literal: true

Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest

  scope '(:locale)', locale: /en|ru/ do
    namespace :admin do
      root 'dashboards#index'
      resources :categories, only: %i[index new edit create update destroy]
      resources :bulletins, only: %i[index] do
        member do
          patch :archive
          patch :publish
          patch :reject
        end
      end
    end

    scope module: :web do
      root 'bulletins#index'

      resources :bulletins, only: %i[index show new edit create update] do
        member do
          patch :archive
          patch :to_moderate
        end
      end

      resource :profile, only: :show
    end
  end

  scope module: :web do
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'auth/logout', to: 'auth#logout'
  end
end
