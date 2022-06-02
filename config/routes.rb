# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :people, only: %i[index show create]
      resources :cities, :states
    end
  end
end
