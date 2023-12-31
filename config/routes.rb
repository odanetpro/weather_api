# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'v1/health#index'

  namespace :v1 do
    get :health, to: 'health#index'

    scope :weather do
      get :by_time, to: 'weather#by_time'
      get :current, to: 'weather#current'

      scope :historical do
        get '/', to: 'weather#historical'
        get 'avg', to: 'weather#historical_avg'
        get 'max', to: 'weather#historical_max'
        get 'min', to: 'weather#historical_min'
      end
    end
  end
end
