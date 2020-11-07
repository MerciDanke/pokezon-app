# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require 'simplecov'
SimpleCov.start

require 'yaml'

require 'minitest/autorun'
require 'minitest/rg'
require 'vcr'
require 'webmock'

require_relative '../init'

ID = '1'.freeze
CORRECT = YAML.safe_load(File.read('spec/fixtures/poke_data/poke1_results.yml'))

CASSETTES_FOLDER = 'spec/fixtures/cassettes'.freeze
CASSETTE_FILE = 'pokemon_api'.freeze
