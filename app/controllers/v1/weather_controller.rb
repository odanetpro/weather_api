# frozen_string_literal: true

module V1
  class WeatherController < ApplicationController
    def current
      render json: Weather.current_temperature, status: :ok
    end
  end
end
