# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'yaml'

require 'minitest/autorun'
require 'minitest/rg'
require 'vcr'
require 'webmock'

require_relative '../lib/amazon_lib/product_api'

POKENAME = 'Pikachu'
CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
API_KEY = CONFIG['API_KEY']
CORRECT = YAML.safe_load(File.read('spec/fixtures/amazon_data/amazon_results.yml'))

CASSETTES_FOLDER = 'spec/fixtures/cassettes'
CASSETTE_FILE = 'product_api'
