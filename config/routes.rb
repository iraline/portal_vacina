# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :people
      resources :cities, :states, :roles, :vaccines, :unities
      resources :localities
      resources :shots, except: [:update]
    end
  end
end
