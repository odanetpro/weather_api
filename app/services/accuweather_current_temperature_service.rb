# frozen_string_literal: true

class AccuweatherCurrentTemperatureService
  LOCATION_ID = 286_867

  Result = Struct.new(:current_temperature, :status) do
    def success?
      current_temperature.present?
    end
  end

  def initialize(client = default_client)
    @client = client
  end

  def call
    response = @client.get(url)

    current_temperature = JSON.parse(response).map do |item|
      {
        EpochTime: item['EpochTime'],
        Temperature: item['Temperature']['Metric']['Value']
      }
    end

    Result.new(current_temperature, response.code)
  rescue RestClient::ExceptionWithResponse => e
    Result.new(nil, e.response.code)
  end

  private

  def default_client
    RestClient
  end

  def url
    "http://dataservice.accuweather.com/currentconditions/v1/#{LOCATION_ID}?apikey=#{Rails.application.credentials.accuweather[:apikey]}"
  end
end
