# frozen_string_literal: true

require 'rails_helper'

describe Weather do
  let(:sample_temperature_data) { [{ 'EpochTime' => '1695799080', 'Temperature' => '18.8' }] }

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
end
