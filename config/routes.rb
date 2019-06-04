# frozen_string_literal: true

Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"

  root 'root#index'

  get '/auth/:provider/callback' => 'sessions#create_from_omniauth'


  namespace :api do
    resources :easypost_events, only: %i(create)
    resources :pubsub_messages, only: %i(create)
  end

  namespace :my do
    resource :dashboard, only: %i(show)

    resources :packages, only: %i(new create index show) do
      resource :tracking_refresh, only: %i(create)
      resource :archival, only: %i(create), controller: 'package_archivals'
    end
    resources :push_notification_registrations, only: %i(index create)
  end
end
