# frozen_string_literal: true

module V1
  class WeatherController < ApplicationController
    def by_time
      nearest_time_temperature = Weather.by_time(params['timestamp'].to_i)

      if nearest_time_temperature.any?
        render json: nearest_time_temperature, status: :ok
      else
        render json: { status: :NOT_FOUND }, status: :not_found
      end
    end

    def current
      render json: Weather.current_temperature, status: :ok
    end

    def historical
      render json: Weather.hourly24_temperature, status: :ok
    end

    def historical_avg
      render json: Weather.hourly24_temperature_avg, status: :ok
    end

    def historical_max
      render json: Weather.hourly24_temperature_max, status: :ok
    end

    def historical_min
      render json: Weather.hourly24_temperature_min, status: :ok
    end
  end
end
