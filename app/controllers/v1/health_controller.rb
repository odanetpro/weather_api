# frozen_string_literal: true

module V1
  class HealthController < ApplicationController
    def index
      render json: { status: :OK }, status: :ok
    end
  end
end
