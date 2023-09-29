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

    it 'returns max temperature' do
      result = described_class.hourly24_temperature_max

      max_temperature = sample_hourly24_temp_data.max_by { |item| item['Temperature'] }

      expect(result[0]).to eq(max_temperature)
    end
  end

  describe 'hourly24_temperature_min' do
    before do
      allow(WeatherApi.redis).to receive(:get).with(:hourly24_temperature).and_return(sample_hourly24_temp_data.to_json)
      allow(WeatherApi.redis).to receive(:set).with(:hourly24_temperature, anything)
    end

    it 'returns min temperature' do
      result = described_class.hourly24_temperature_min

      min_temperature = sample_hourly24_temp_data.min_by { |item| item['Temperature'] }

      expect(result[0]).to eq(min_temperature)
    end
  end

  describe 'hourly24_temperature_avg' do
    before do
      allow(WeatherApi.redis).to receive(:get).with(:hourly24_temperature).and_return(sample_hourly24_temp_data.to_json)
      allow(WeatherApi.redis).to receive(:set).with(:hourly24_temperature, anything)
    end

    it 'returns average temperature' do
      result = described_class.hourly24_temperature_avg

      temperatures = result.pluck('Temperature')
      avg_temperature = (temperatures.sum / temperatures.size).ceil(1)

      expect(result[0]['Temperature']).to eq(avg_temperature)
    end
  end

  describe 'by_time' do
    before do
      allow(WeatherApi.redis).to receive(:get).with(:hourly24_temperature).and_return(sample_hourly24_temp_data.to_json)
      allow(WeatherApi.redis).to receive(:set).with(:hourly24_temperature, anything)
    end

    it 'returns the nearest by time temperature' do
      sample_timestamp = Time.current.to_i + (23 * 3600)

      result = described_class.by_time(sample_timestamp)

      expect(result).to eq([sample_hourly24_temp_data[23]])
    end

    it 'the nearest time temperature was not found' do
      sample_timestamp = Time.current.to_i - 3601

      result = described_class.by_time(sample_timestamp)

      expect(result).to be_empty
    end
  end
end
