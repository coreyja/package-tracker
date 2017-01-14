Rails.application.routes.draw do
  root 'static#index'

  namespace :my do
    resources :packages, only: %i(new create)
  end
end
