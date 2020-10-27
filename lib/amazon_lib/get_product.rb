# frozen_string_literal: true

require 'http'
require 'yaml'
require 'json'

def amazon_api_path(config, poke_name)
  "https://api.zilerate.com/amazon/category?apiKey=#{config['API_KEY']}&url=https%3A%2F%2Fwww.amazon.com%2Fs%3Fk%3D#{poke_name}"
end

# after call_amazon_url we get the json object
def call_amazon_url(url)
  JSON.parse(
    HTTP
      .get(URI(url))
  )
end

amazon_results = {}
config = YAML.safe_load(File.read('config/secrets.yml'))
url = amazon_api_path(config, 'Pikachu')
amazon_obj = call_amazon_url(url)

product_index = 1
amazon_obj['results'].map do |element|
  amazon_results[product_index] = element
  product_index += 1
end

# put the product results into the yaml file
File.write('spec/fixtures/amazon_data/amazon_results.yml', amazon_results.to_yaml)
