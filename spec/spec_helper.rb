# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'yaml'

require 'minitest/autorun'
require 'minitest/rg'
require 'vcr'
require 'webmock'

require_relative '../lib/poke_lib/pokemon_api'

ID = 'fdfd'
CORRECT = YAML.safe_load(File.read('spec/fixtures/poke_data/poke1_results.yml'))

CASSETTES_FOLDER = 'spec/fixtures/cassettes'
CASSETTE_FILE = 'pokemon_api'
