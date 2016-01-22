# OpenWeatherLite
[![Build Status](https://travis-ci.org/zsyed91/openweatherlite.svg)](https://travis-ci.org/zsyed91/openweatherlite)

Simple ruby wrapper for the [OpenWeatherMap](http://openweathermap.org/) api. The only
hard requirements for this client is to register for an api key. This project intentionally
does not implement all of the api endpoints to keep it light. Inspiration came from
using it on a raspberry pi to ping the current weather state every 30 seconds.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'openweatherlite'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install openweatherlite

## Example

```
  weather = OpenWeatherLite::Weather.new('api_key')
  weather.by_zip_code(60606)
```

## Usage

### `OpenWeatherLite::Weather`
This class is the api class for openweather

#### attributes
- `api_key`
- `units` (metric, imperial)

#### initialize
Provide an optional api_key

```
  # With optional api_key
  OpenWeatherLite::Weather.new('api_key')

  # Without api key
  weather = OpenWeatherLite::Weather.new
  weather.api_key = 'api_key'
```

#### by_zip_code
Provide `zip_code` and optionally `country`. `country` defaults to `us`. Returns `OpenWeatherLite::WeatherResponse`

```
  weather = OpenWeatherLite::Weather.new('api_key')
  # returns OpenWeatherLite::WeatherResponse
  response = weather.by_zip_code(60606)
```

#### by_city_id
Provide a `city_id` according to openweathermap and returns `OpenWeatherLite::WeatherResponse`

```
  # returns OpenWeatherLite::WeatherResponse
  weather.by_city_id(2172797)
```

#### by_coords
Provide `latitude` and `longitude` and returns `OpenWeatherLite::WeatherResponse`

```
# returns OpenWeatherLite::WeatherResponse
  weather.by_coords(35, 139)
```

### `OpenWeatherLite::WeatherResponse`

#### coords
Returns a hash of the coordinates

```
  response.coords
  # { latitude: 123, longitude: 123 }
```

#### temperature
Returns the temperature value from the reponse. Unit is in units provided by to `OpenWeatherLite::Weather`

```
  response.temperature
```

#### pressure
Returns the pressure value from the response

```
  response.pressure
```

#### humidity
Returns the humidity value from the response

```
  response.humidity
```

#### temperature_range
Returns an `array` with the `[min, max]` values from the response

```
  response.temperature_range
```

#### wind
Returns the wind details `hash` with `speed` and `deg` from the response

```
  response.wind
```

#### cloudy?
Returns `true` or `false` if there are any clouds

```
  response.cloudy?
```
#### clouds
Returns the percentage of clouds in a `hash`

```
  response.clouds
```

#### rainy?
Returns `true` or `false` depending on whether it is, or has rained in the past 3 hours

#### rain
Returns the amount that it has rained in the last 3 hours in a hash
```
  response.rain
  # { '3h' => .445 }
```
#### snow?
Returns `true` or `false` depending on whether it is, or has rained in the past 3 hours

```
  response.snowy?
```

#### snow
Returns the amount that it has snowed in the last 3 hours in a hash

```
  response.snow
  # { '3h' => .445 }
```

#### sunrise
Returns the time for sunrise today

```
  response.sunrise
```

#### sunset
Returns the time for sunset today

```
  response.sunset
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/zsyed91/openweatherlite. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

