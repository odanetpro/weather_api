# frozen_string_literal: true

module WeatherApi
  def self.redis
    @redis ||= Redis::Namespace.new(:weather_api, redis: Redis.new)
  end
end
