# frozen_string_literal: true

require 'http'
require 'json'
require_relative 'product'

module ProductInf
  # Library for Pokemon API
  class ProductApi
    config = YAML.safe_load(File.read('config/secrets.yml'))
    API_PRODUCT_ROOT = "https://api.zilerate.com/amazon/category?apiKey=#{config['API_KEY']}&url=https%3A%2F%2Fwww.amazon.com%2Fs%3Fk%3D"

    module Errors
      class NotFound < StandardError; end
    end
    HTTP_ERROR = {
      404 => Errors::NotFound
    }.freeze

    # e.g. poke_name = pikachu
    def product(poke_name)
      # product api url
      product_data = call_product_url(product_api_path(poke_name))['results'][0]
      Product.new(product_data)
    end

    private

    def product_api_path(path)
      "#{API_PRODUCT_ROOT}/#{path}"
    end

    def call_product_url(url)
      result = HTTP.get(url)
      successful?(result) ? JSON.parse(result) : raise(HTTP_ERROR[result.code])
    end

    def successful?(result)
      HTTP_ERROR.keys.include?(result.code) ? false : true
    end
  end
end
