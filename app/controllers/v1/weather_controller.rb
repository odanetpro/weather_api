# frozen_string_literal: true

module V1
  class WeatherController < ApplicationController
    def current
      render json: Weather.current_temperature, status: :ok
    end

    def historical
      render json: Weather.hourly24_temperature, status: :ok
    end

    def historical_max
      render json: Weather.hourly24_temperature_max, status: :ok
    end

    def historical_min
      render json: Weather.hourly24_temperature_min, status: :ok
    end

    def historical_avg
      render json: Weather.hourly24_temperature_avg, status: :ok
    end
  end
end
