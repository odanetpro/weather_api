# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'v1/health#index'

  namespace :v1 do
    get :health, to: 'health#index'

    scope :weather do
      get :current, to: 'weather#current'

      scope :historical do
        get '/', to: 'weather#historical'
        get 'max', to: 'weather#historical_max'
      end
    end
  end
end
