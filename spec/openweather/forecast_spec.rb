require 'spec_helper'

describe Openweather::Weather do
  before do
    base_url = 'http://api.openweathermap.org/data/2.5/weather'

    stub_request(:get, base_url + "?zip=60606,us&appid=#{api_key}")
      .to_return(body: weather_response)
  end

  let(:root_path) { File.dirname(__FILE__) + '/../../' }

  let(:api_key) { 'api_key' }
  let(:zip_code) { '60606' }
  let(:forecast) { Openweather::Weather.new(api_key) }
  let(:weather_response) do
    File.read(root_path + 'spec/responses/weather.json')
  end

  describe '#intialize' do
    it 'should take in a single optional parameter' do
      expect { Openweather::Weather.new }.not_to raise_error
      expect { Openweather::Weather.new(api_key) }.not_to raise_error
    end
  end

  describe '#by_zip_code' do
    context 'given all required info' do
      it 'should return the forecast for a zip_code' do
        response = forecast.by_zip_code(zip_code)
        expect(response).to include(:coord, :weather, :main, :wind,
                                    :clouds, :name, :dt, :sys)
      end
    end
  end
end
