# frozen_string_literal: false

require 'http'

module ProductInf
  module Amazon
    # Library for Amazon Web API
    class Api
      def product_data(poke_name, apikey)
        Request.new.product(poke_name, apikey).parse
      end

      # Sends out HTTP requests to Github
      class Request
        AMAZON_PATH = 'https://api.zilerate.com/amazon/category?url=https%3A%2F%2Fwww.amazon.com%2Fs%3Fk%3D'.freeze
        # "https://api.zilerate.com/amazon/category?apiKey=#{config['API_KEY']}&url=https%3A%2F%2Fwww.amazon.com%2Fs%3Fk%3D#{poke_name}"

        def product(poke_name, apikey)
          get(AMAZON_PATH + [poke_name, apikey].join('&apiKey='))
        end

        def get(url)
          http_response = HTTP.get(url)

          Response.new(http_response).tap do |response|
            raise(response.error) unless response.successful?
          end
        end
      end

      # Decorates HTTP responses from Github with success/error
      class Response < SimpleDelegator
        Unauthorized = Class.new(StandardError)
        NotFound = Class.new(StandardError)

        HTTP_ERROR = {
          401 => Unauthorized,
          404 => NotFound
        }.freeze

        def successful?
          HTTP_ERROR.keys.include?(code) ? false : true
        end

        def error
          HTTP_ERROR[code]
        end
      end
    end
  end
end