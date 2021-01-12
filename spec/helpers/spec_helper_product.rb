# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require 'simplecov'
SimpleCov.start

require 'yaml'
require 'minitest/autorun'
require 'minitest/rg'

require_relative '../../init'

POKENAME = 'bulbasaur'
PROD_ID = '1'

# Helper methods
def homepage
  MerciDanke::App.config.APP_HOST
end
