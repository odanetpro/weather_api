# frozen_string_literal: true

require 'rails_helper'

describe 'Weather API', type: :request do
  let(:request_headers) do
    { 'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json' }
  end

  describe 'GET /v1/weather/historical' do
    before { get '/v1/weather/historical', headers: request_headers }

    it 'returns 200 status' do
      expect(response).to have_http_status :ok
    end

    it 'returns hourly 24 temperature' do
      expect(json).to all(have_key('EpochTime').and(have_key('Temperature')))
    end

    it 'get 24 hours' do
      expect(json.size).to eq(24)
    end
  end
end
