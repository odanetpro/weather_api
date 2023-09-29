# frozen_string_literal: true

require 'rails_helper'

Result = Struct.new(:current_temperature, :status) do
  def success?
    current_temperature.present?
  end
end

describe LoadCurrentTemperatureJob do
  let(:service) { double(AccuweatherCurrentTemperatureService) }
  let(:result) do
    Result.new(current_temperature: [{ 'EpochTime' => 1_695_799_080, 'Temperature' => 18.8 }], status: 200)
  end

  before do
    allow(AccuweatherCurrentTemperatureService).to receive(:new).and_return(service)
  end

  it 'calls AccuweatherCurrentTemperatureService' do
    expect(service).to receive(:call).and_return(result)
    described_class.perform_now
  end

  it 'sets current weather' do
    allow(service).to receive(:call).and_return(result)
    Weather.current_temperature = {}

    described_class.perform_now

    expect(Weather.current_temperature).to eq(result.current_temperature)
  end
end
