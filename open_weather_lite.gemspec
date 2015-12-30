# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'open_weather_lite/version'

Gem::Specification.new do |spec|
  spec.name          = 'open_weather_lite'
  spec.version       = OpenWeatherLite::VERSION
  spec.authors       = ['Zshawn Syed']
  spec.email         = ['zsyed91@gmail.com']

  spec.summary       = 'Simple ruby wrapper for the OpenWeatherMap api'
  spec.description   = 'Wrapper class for the OpenWeatherMap api.' \
                       'Provides a simple interface to the api calls.' \
                       'Api version is configurable. Only dependency is the api key!'

  spec.homepage      = 'https://github.com/zsyed91/openweatherlite'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'pry'

  spec.add_dependency 'bundler', '~> 1.10'
  spec.add_dependency 'rake', '~> 10.0'
  spec.add_dependency 'rest-client'
end
