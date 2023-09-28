# frozen_string_literal: true

require 'rails_helper'

describe Weather do
  let(:sample_temperature_data) { [{ 'EpochTime' => '1695799080', 'Temperature' => '18.8' }] }
  let(:sample_hourly24_temp_data) do
    Array.new(24) do |i|
      { 'EpochTime' => Time.current.to_i + (i * 3600), 'Temperature' => rand(10.0..30.0).round(1) }
    end
  end

  describe 'current temperature' do
    before do
      allow(WeatherApi.redis).to receive(:get).with(:current_temperature).and_return(sample_temperature_data.to_json)
      allow(WeatherApi.redis).to receive(:set).with(:current_temperature, anything)
    end

    it 'getter' do
      result = described_class.current_temperature

      expect(result).to eq(sample_temperature_data)
    end

    it 'setter' do
      new_temperature_data = [{ 'EpochTime' => '1695711480', 'Temperature' => '20.1' }]
      described_class.current_temperature = new_temperature_data

      expect(WeatherApi.redis).to have_received(:set).with(:current_temperature, new_temperature_data.to_json)
    end
  end

  describe 'hourly24_temperature' do
    before do
      allow(WeatherApi.redis).to receive(:get).with(:hourly24_temperature).and_return(sample_hourly24_temp_data.to_json)
      allow(WeatherApi.redis).to receive(:set).with(:hourly24_temperature, anything)
    end

    it 'getter' do
      result = described_class.hourly24_temperature

      expect(result).to eq(sample_hourly24_temp_data)
    end

    it 'setter' do
      new_temperature_data = [{ 'EpochTime' => '1695711480', 'Temperature' => '20.1' }]
      described_class.hourly24_temperature = new_temperature_data

      expect(WeatherApi.redis).to have_received(:set).with(:hourly24_temperature, new_temperature_data.to_json)
    end
  end

  describe 'hourly24_temperature_max' do
    before do
      allow(WeatherApi.redis).to receive(:get).with(:hourly24_temperature).and_return(sample_hourly24_temp_data.to_json)
      allow(WeatherApi.redis).to receive(:set).with(:hourly24_temperature, anything)
    end

    it 'return max temperature' do
      result = described_class.hourly24_temperature_max

      max_temperature = sample_hourly24_temp_data.max_by { |item| item['Temperature'] }

      expect(result[0]).to eq(max_temperature)
    end
  end
end
