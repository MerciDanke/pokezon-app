# frozen_string_literal: true

require 'dry/transaction'

module MerciDanke
  module Service
    # Retrieves array of all listed product entities
    class ListProducts
      include Dry::Transaction

      step :get_api_list
      step :reify_list

      private

      def get_api_list(products_list)
        return Success(products_list) if products_list.length.zero?

        Gateway::Api.new(MerciDanke::App.config)
          .products_list(products_list)
          .then do |result|
            result.success? ? Success(result.payload) : Failure(result.message)
          end
      rescue StandardError
        Failure('Could not access our API')
      end

      def reify_list(products_json)
        return Success(products_json) if products_json.length.zero?

        Representer::ProductsList.new(OpenStruct.new)
          .from_json(products_json)
          .then { |products| Success(products) }
      rescue StandardError
        Failure('Could not parse response from API')
      end
    end
  end
end
