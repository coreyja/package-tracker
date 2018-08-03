# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static#index'

  get '/auth/:provider/callback' => 'sessions#create_from_omniauth'

  namespace :api do
    resources :easypost_events, only: %i(create)
  end

  namespace :my do
    resources :packages, only: %i(new create index show) do
      resource :tracking_refresh, only: %i(create)
    end
  end
end
