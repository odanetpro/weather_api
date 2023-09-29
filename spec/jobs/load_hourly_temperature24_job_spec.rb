# frozen_string_literal: true

require 'rails_helper'

Result24 = Struct.new(:hourly_temperature, :status) do
  def success?
    hourly_temperature.present?
  end
end

describe LoadHourlyTemperature24Job do
  let(:service) { double(AccuweatherHourlyTemperature24Service) }
  let(:temperatures) do
    Array.new(24) do |i|
      { 'EpochTime' => Time.current.to_i + (i * 3600), 'Temperature' => rand(10.0..30.0).round(1) }
    end
  end
  let(:result) { Result24.new(hourly_temperature: temperatures, status: 200) }

  before do
    allow(AccuweatherHourlyTemperature24Service).to receive(:new).and_return(service)
  end

  it 'calls AccuweatherHourlyTemperature24Service' do
    expect(service).to receive(:call).and_return(result)
    described_class.perform_now
  end

  it 'sets current weather' do
    allow(service).to receive(:call).and_return(result)
    Weather.hourly24_temperature = {}

    described_class.perform_now

    expect(Weather.hourly24_temperature).to eq(result.hourly_temperature)
  end
end
