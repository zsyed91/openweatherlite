module Openweather
  # Look up current weather conditions by available api calls
  #   all methods return parsed json response objects
  class Weather
    VERSION = '2.5'
    BASE_URL = 'http://api.openweathermap.org/data/'
    attr_accessor :version, :api_key

    def initialize(api_key = nil)
      @api_key = api_key
      @version = VERSION
    end

    def by_zip_code(zip_code, country = 'us')
      run(zip: "#{zip_code},#{country}")
    end

    private

    def run(params = nil)
      params[:appid] = @api_key

      response = RestClient::Request.execute(method: :get, url: url(params))
      JSON.parse(response, symbolize_names: true)
    end

    def url(params)
      "#{BASE_URL}#{version}/weather?" + params_to_string(params)
    end

    def params_to_string(params)
      params.map { |key, value| "#{key}=#{value}" }.join('&')
    end
  end
end
