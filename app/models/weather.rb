# frozen_string_literal: true

class Weather
  def self.current_temperature
    JSON.parse(WeatherApi.redis.get(:current_temperature))
  end

  def self.current_temperature=(value)
    WeatherApi.redis.set :current_temperature, value.to_json
  end
end
