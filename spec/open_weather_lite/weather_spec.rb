require 'spec_helper'

describe OpenWeatherLite::Weather do
  before do
    base_url = 'http://api.openweathermap.org/data/2.5/weather?'

    # by zip code --------------------------------------------------------------
    stub_request(:get, base_url + "zip=60606,us&appid=#{api_key}")
      .to_return(body: weather_response)

    stub_request(:get,
                 base_url + "zip=60606,us&appid=#{api_key}&units=imperial")
      .to_return(body: weather_response)

    stub_request(:get, base_url + 'zip=60606,us&appid=invalid')
      .to_return(status: 401)

    # By city id ---------------------------------------------------------------
    stub_request(:get, base_url + "id=#{city_id}&appid=#{api_key}")
      .to_return(body: weather_response)

    stub_request(:get,
                 base_url + "id=#{city_id}&appid=#{api_key}&units=imperial")
      .to_return(body: weather_response)

    stub_request(:get,
                 base_url + "id=#{city_id}&appid=#{api_key}&units=imperial")
      .to_return(body: weather_response)

    stub_request(:get, base_url + "id=#{city_id}&appid=invalid")
      .to_return(status: 401)

    # by coordinates -----------------------------------------------------------
    stub_request(:get,
                 base_url + "lat=#{latitude}&lon=#{longitude}&appid=#{api_key}")
      .to_return(body: weather_response)

    stub_request(:get,
                 base_url + "lat=#{latitude}&lon=#{longitude}&appid=invalid")
      .to_return(status: 401)
  end

  let(:api_key) { 'api_key' }
  let(:zip_code) { 60_606 }
  let(:country_code) { 'us' }
  let(:city_id) { 4_887_398 }
  let(:longitude) { -87.65 }
  let(:latitude) { 41.85 }
  let(:weather) { OpenWeatherLite::Weather.new(api_key) }
  let(:weather_response) do
    File.read(root_path + 'spec/responses/weather.json')
  end

  describe '#intialize' do
    it 'should take in a single optional parameter' do
      expect { OpenWeatherLite::Weather.new }.not_to raise_error
      expect { OpenWeatherLite::Weather.new(api_key) }.not_to raise_error
    end
  end

  describe '#by_zip_code' do
    context 'given all required info' do
      it 'should return the weather for a zip_code' do
        response = weather.by_zip_code(zip_code)
        expect(response.weather).to include(:coord, :weather, :main, :wind,
                                            :clouds, :name, :dt, :sys)
      end

      it 'should return the weather for a zip_code and country_code' do
        response = weather.by_zip_code(zip_code, country_code)
        expect(response.weather).to include(:coord, :weather, :main, :wind,
                                            :clouds, :name, :dt, :sys)
      end

      it 'should return the correct units when given a unit type' do
        weather.units = 'imperial'
        response = weather.by_zip_code(zip_code)
        expect(response.weather).to include(:coord, :weather, :main, :wind,
                                            :clouds, :name, :dt, :sys)
      end
    end

    context 'given invalid info' do
      it 'should return an error if missing api_key' do
        weather = OpenWeatherLite::Weather.new
        expect { weather.by_zip_code(zip_code) }.to(
          raise_error(ArgumentError, 'Missing api key'))
      end

      it 'should return a 401 if invalid api_key used' do
        weather.api_key = 'invalid'
        expect { weather.by_zip_code(zip_code) }.to(
          raise_error(RestClient::Unauthorized))
      end
    end
  end

  describe '#by_city_id' do
    context 'given all required info' do
      it 'should return the weather for the city_id' do
        response = weather.by_city_id(city_id)
        expect(response.weather).to include(:coord, :weather, :main, :wind,
                                            :clouds, :name, :dt, :sys)
        expect(response.weather[:id]).to eq(city_id)
      end

      it 'should return the correct units when given a unit type' do
        weather.units = 'imperial'
        response = weather.by_city_id(city_id)
        expect(response.weather).to include(:coord, :weather, :main, :wind,
                                            :clouds, :name, :dt, :sys)
      end
    end

    context 'given invalid info' do
      it 'should return an error if invalid api_key used' do
        weather.api_key = 'invalid'
        expect { weather.by_city_id(city_id) }.to(
          raise_error(RestClient::Unauthorized))
      end
    end
  end

  describe '#by_coords' do
    context 'given all required info' do
      it 'should return the weather for lat and lon' do
        response = weather.by_coords(latitude, longitude)
        expect(response.weather).to include(:coord, :weather, :main, :wind,
                                            :clouds, :name, :dt, :sys)
        expect(response.weather[:coord][:lat]).to eq(latitude)
        expect(response.weather[:coord][:lon]).to eq(longitude)
      end
    end
  end
end
