# frozen_string_literal: true

require 'rails_helper'

describe AccuweatherHourlyTemperature24Service do
  let(:service) { described_class.new }

  it 'can successfully get result' do
    VCR.use_cassette('hourly_temperature_24_cassete') do
      result = service.call

      expect(result.status).to eq(200)
    end
  end

  it 'can determine the success of execution' do
    VCR.use_cassette('hourly_temperature_24_cassete') do
      result = service.call

      expect(result.success?).to be_truthy
    end
  end

  it 'get last hours temperature from accuweather' do
    VCR.use_cassette('hourly_temperature_24_cassete') do
      result = service.call

      expect(result.hourly_temperature).to all(have_key(:EpochTime).and(have_key(:Temperature)))
    end
  end

  it 'get 24 hours' do
    VCR.use_cassette('hourly_temperature_24_cassete') do
      result = service.call

      expect(result.hourly_temperature.size).to eq(24)
    end
  end
end
