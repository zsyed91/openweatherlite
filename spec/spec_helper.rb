$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'open_weather_lite'
require 'webmock/rspec'
require 'pry'

def root_path
  File.dirname(__FILE__) + '/../'
end
