# frozen_string_literal: true

require 'http'
require 'yaml'
require 'json'

config = YAML.safe_load(File.read('config/secrets.yml'))

def amazon_api_path(poke_name)
  "https://api.zilerate.com/amazon/category?apiKey=oT9JPPCi164yAgGmUFj6n7vkZ9N4gRiD8kPyCZRJ&url=https%3A%2F%2Fwww.amazon.com%2Fs%3Fk%3D#{poke_name}"
end

# after call_poke_url we get the json object
def call_amazon_url(url)
  JSON.parse(
    HTTP
      .get(URI(url))
  )
end

amazon_results = {}

url = amazon_api_path('Pikachu')
amazon_obj = call_amazon_url(url)
i = 1
amazon_obj['results'].map do |element|
  amazon_results[i] = element
  i += 1
end

# put the pokemon1's abilities, height, weight into the yaml file
File.write('spec/fixtures/amazon_data/amazon_results.yml', amazon_results.to_yaml)
