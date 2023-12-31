# frozen_string_literal: true

Sidekiq.configure_server do |config|
  config.redis = { url: WeatherApi::REDIS_URL }
end

Sidekiq.configure_client do |config|
  config.redis = { url: WeatherApi::REDIS_URL }
end
