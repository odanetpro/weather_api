# frozen_string_literal: true

require 'rails_helper'

describe 'Weather API', type: :request do
  let(:request_headers) do
    { 'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json' }
  end
  let(:sample_hourly24_temp_data) do
    Array.new(24) do |i|
      { 'EpochTime' => Time.current.to_i + (i * 3600), 'Temperature' => rand(10.0..30.0).round(1) }
    end
  end

  describe 'GET /v1/weather/by_time' do
    before { Weather.hourly24_temperature = sample_hourly24_temp_data }

    describe 'found' do
      let(:nearest_time) { Time.current.to_i + (23 * 3600) }

      before { get "/v1/weather/by_time?timestamp=#{nearest_time}", headers: request_headers }

      it 'returns 200 status' do
        expect(response).to have_http_status :ok
      end

      it 'returns the nearest by time temperature' do
        expect(json[0]).to eq(sample_hourly24_temp_data[23])
      end
    end

    describe 'not found' do
      let(:distant_time) { Time.current.to_i - 3600 }

      before { get "/v1/weather/by_time?timestamp=#{distant_time}", headers: request_headers }

      it 'returns 404 status' do
        expect(response).to have_http_status :not_found
      end
    end
  end
end
