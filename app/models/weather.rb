# frozen_string_literal: true

class Weather
  def self.current_temperature
    JSON.parse(WeatherApi.redis.get(:current_temperature))
  end

  def self.current_temperature=(value)
    WeatherApi.redis.set :current_temperature, value.to_json
  end

  def self.hourly24_temperature
    JSON.parse(WeatherApi.redis.get(:hourly24_temperature))
  end

  def self.hourly24_temperature=(value)
    WeatherApi.redis.set :hourly24_temperature, value.to_json
  end

  def self.hourly24_temperature_max
    [hourly24_temperature.max_by { |item| item['Temperature'] }]
  end

  def self.hourly24_temperature_min
    [hourly24_temperature.min_by { |item| item['Temperature'] }]
  end
end
