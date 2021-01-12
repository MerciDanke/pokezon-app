# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require 'simplecov'
SimpleCov.start

require 'yaml'
require 'minitest/autorun'
require 'minitest/rg'

require_relative '../../init'

ID = '1'
POKE_NAME = 'bulbasaur'

# Helper methods
def homepage
  MerciDanke::App.config.APP_HOST
end
