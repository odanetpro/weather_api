# frozen_string_literal: true

require 'rails_helper'

describe 'Health API', type: :request do
  let(:request_headers) do
    { 'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json' }
  end

  describe 'GET /v1/health' do
    before { get '/v1/health', headers: request_headers }

    it 'returns 200 status' do
      expect(response).to have_http_status :ok
    end

    it 'returns json with status ok' do
      expect(json[:status]).to eq 'OK'
    end
  end
end
