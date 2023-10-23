# frozen_string_literal: true

module WeatherApi
  REDIS_URL = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0') }.freeze

  def self.redis
    @redis ||= Redis::Namespace.new(:weather_api, redis: Redis.new(REDIS_URL))
  end
end
