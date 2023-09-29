# frozen_string_literal: true

require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.in '1s' do
  LoadCurrentTemperatureJob.perform_later
  LoadHourlyTemperature24Job.perform_later
end

scheduler.every '1h' do
  LoadHourlyTemperature24Job.perform_later
end

scheduler.every '15m' do
  LoadCurrentTemperatureJob.perform_later
end
