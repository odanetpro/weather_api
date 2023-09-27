# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'v1/health#index'

  namespace :v1 do
    get :health, to: 'health#index'

    scope :weather do
      get :current, to: 'weather#current'
    end
  end
end
