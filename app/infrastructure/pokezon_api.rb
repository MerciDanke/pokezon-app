# frozen_string_literal: true

require_relative 'list_request'
require 'http'

module MerciDanke
  module Gateway
    # Infrastructure to call Pokezon API
    class Api
      def initialize(config)
        @config = config
        @request = Request.new(@config)
      end

      def alive?
        @request.get_root.success?
      end

      def add_product(poke_name)
        @request.add_product(poke_name)
      end

      def like_product(origin_id)
        @request.like_product(origin_id)
      end

      def all_pokemon
        @request.all_pokemon
      end

      def add_pokemon(poke_name)
        @request.add_pokemon(poke_name)
      end

      def like_pokemon(id)
        @request.like_pokemon(id)
      end

      def products_list(list)
        @request.products_list(list)
      end

      def advance_list(list)
        @request.advance_list(list)
      end

      def products_filter(poke_name, list)
        @request.products_filter(poke_name, list)
      end

      # HTTP request transmitter
      class Request
        def initialize(config)
          api_host = config.API_HOST
          @api_host = api_host
          @api_root = api_host + '/api/v1'
        end

        def get_root # rubocop:disable Naming/AccessorMethodName
          call_api('get')
        end

        def add_product(poke_name)
          call_api('get', ['products', poke_name])
        end

        def like_product(origin_id)
          call_api('put', ["product/#{origin_id}/likes"])
        end

        def all_pokemon
          call_api('get', ['pokemon'])
        end

        def add_pokemon(poke_name)
          call_api('get', ['pokemon', poke_name])
        end

        def like_pokemon(id)
          call_api('put', ["pokemon/#{id}/likes"])
        end

        def products_list(list)
          call_api('get', ['products', list])
        end

        def advance_list(list)
          call_api('get', ["pokemon?#{list}"])
        end

        def products_filter(poke_name, list)
          call_api('get', ["products/#{poke_name}?#{list}"])
        end

        private

        def params_str(params)
          params.map { |key, value| "#{key}=#{value}" }.join('&')
            .then { |str| str || '' }
        end

        def call_api(method, resources = [], params = {})
          api_path = resources.empty? ? @api_host : @api_root
          url = [api_path, resources].flatten.join('/') + params_str(params)
          HTTP.headers('Accept' => 'application/json').send(method, url)
            .then { |http_response| Response.new(http_response) }
        rescue StandardError
          raise "Invalid URL request: #{url}"
        end
      end

      # Decorates HTTP responses with success/error
      class Response < SimpleDelegator
        # HTTP is NotFound
        NotFound = Class.new(StandardError)

        SUCCESS_CODES = (200..299).freeze

        def success?
          code.between?(SUCCESS_CODES.first, SUCCESS_CODES.last)
        end

        def failure?
          !success?
        end

        def ok?
          code == 200
        end

        def added?
          code == 201
        end

        def processing?
          code == 202
        end

        def message
          payload['message']
          JSON.parse(payload)['message']
        end

        def payload
          body.to_s
        end
      end
    end
  end
end
