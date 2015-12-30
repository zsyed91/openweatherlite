require 'spec_helper'

describe OpenWeatherLite::WeatherResponse do
  let(:weather_response) do
    File.read(root_path + 'spec/responses/weather.json')
  end
  let(:response) { OpenWeatherLite::WeatherResponse.new(weather_response) }
  let(:json) do
    JSON.parse(File.read(root_path + 'spec/responses/weather.json'),
               symbolize_names: true)
  end
  let(:latitude) { json[:coord][:lat] }
  let(:longitude) { json[:coord][:lon] }
  let(:temperature) { json[:main][:temp] }
  let(:pressure) { json[:main][:pressure] }
  let(:humidity) { json[:main][:humidity] }
  let(:temperature_range) { [json[:main][:temp_min], json[:main][:temp_max]] }
  let(:wind) { json[:wind] }
  let(:sunrise) { json[:sys][:sunrise] }
  let(:sunset) { json[:sys][:sunset] }

  describe '#initialize' do
    it 'should take in the response json' do
      expect { OpenWeatherLite::WeatherResponse.new(weather_response) }.not_to(
        raise_error)
      expect { OpenWeatherLite::WeatherResponse.new }.to(
        raise_error(ArgumentError))
    end
  end

  describe '#coords' do
    it 'should return the coordinates' do
      coords = { latitude: latitude, longitude: longitude }
      expect(response.coords).to eq(coords)
    end
  end

  describe '#temperature' do
    it 'should return the temperature' do
      expect(response.temperature).to eq(temperature)
    end
  end

  describe '#pressure' do
    it 'should return the pressure' do
      expect(response.pressure).to eq(pressure)
    end
  end

  describe '#humidity' do
    it 'should return the humidity' do
      expect(response.humidity).to eq(humidity)
    end
  end

  describe '#temperature_range' do
    it 'should return the temperature range' do
      expect(response.temperature_range).to eq(temperature_range)
    end
  end

  describe '#wind' do
    it 'should return the wind details' do
      expect(response.wind).to eq(wind)
    end
  end

  describe '#cloudy?' do
    it 'should return true if its cloudy' do
      expect(response.cloudy?).to be(true)
    end

    it 'should return false if its not cloudy' do
      response.weather[:clouds][:all] = 0
      expect(response.cloudy?).to be(false)

      response.weather[:clouds] = nil
      expect(response.cloudy?).to be(false)
    end
  end

  describe '#clouds' do
    it 'should return the cloudiness percentage' do
      expect(response.clouds).to eq(90)
    end
  end

  describe '#rainy?' do
    it 'should return true if it has rained in the last 3 hours' do
      response.weather[:rain] = {}
      response.weather[:rain][:'3h'] = 2
      expect(response.rainy?).to be(true)
    end

    it 'should return false if it has not rained in the last 3 hours' do
      expect(response.rainy?).to be(false)
    end
  end

  describe '#rain' do
    it 'should return the amount of rain in the last 3 hours' do
      expect(response.rain).to eq(0)
      response.weather[:rain] = { '3h': 10 }
      expect(response.rain).to eq(10)
    end
  end

  describe '#snowy?' do
    it 'should return true if it has snowed in the last 3 hours' do
      response.weather[:snow] = { '3h': 12 }
      expect(response.snowy?).to be(true)
    end

    it 'should return false if it not snowed in the last 3 hours' do
      expect(response.snowy?).to be(false)
      response.weather[:snow] = { '3h': 0 }
      expect(response.snowy?).to be(false)
    end
  end

  describe '#snow' do
    it 'should return the amount of snow in the last 3 hours' do
      expect(response.snow).to eq(0)
      response.weather[:snow] = { '3h': 10 }
      expect(response.snow).to eq(10)
    end
  end

  describe '#sunrise' do
    it 'should return the sunrise time' do
      expect(response.sunrise).to eq(sunrise)
    end
  end

  describe '#sunset' do
    it 'should return the sunset time' do
      expect(response.sunset).to eq(sunset)
    end
  end
end
