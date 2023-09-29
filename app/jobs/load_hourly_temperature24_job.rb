# frozen_string_literal: true

class LoadHourlyTemperature24Job < ApplicationJob
  queue_as :default

  def perform
    result = AccuweatherHourlyTemperature24Service.new.call
    Weather.hourly24_temperature = result.hourly_temperature if result.success?
  end
end
