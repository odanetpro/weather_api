# frozen_string_literal: true

require 'rails_helper'

describe AccuweatherCurrentTemperatureService do
  let(:service) { described_class.new }

  it 'can successfully get result' do
    VCR.use_cassette('current_temperature_cassete') do
      result = service.call

      expect(result.status).to eq(200)
    end
  end

  it 'can determine the success of execution' do
    VCR.use_cassette('current_temperature_cassete') do
      result = service.call

      expect(result.success?).to be_truthy
    end
  end

  it 'get current temperature from accuweather' do
    VCR.use_cassette('current_temperature_cassete') do
      result = service.call

      expect(result.current_temperature.first).to have_key(:EpochTime).and have_key(:Temperature)
    end
  end
end
