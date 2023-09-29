# frozen_string_literal: true

class LoadCurrentTemperatureJob < ApplicationJob
  queue_as :default

  def perform
    result = AccuweatherCurrentTemperatureService.new.call
    Weather.current_temperature = result.current_temperature if result.success?
  end
end
