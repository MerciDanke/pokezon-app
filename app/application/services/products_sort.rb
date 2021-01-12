# frozen_string_literal: true

require 'dry/transaction'

module MerciDanke
  module Service
    # Transaction to sort product from Amazon API to database
    class ProductSort
      include Dry::Transaction

      step :validate_input
      step :request_products
      step :reify_products

      private

      def validate_input(input)
        if input
          poke_name = input[:poke_name]
          query_string = input[:query_string]
          Success(poke_name: poke_name, query_string: query_string)
        else
          Failure('Could not find that sort!')
        end
      end

      def request_products(input)
        input[:response] = gateway_product(input[:poke_name], input[:query_string])
        response = input[:response]
        response.success? ? Success(input) : Failure(response.message)
      rescue StandardError
        Failure('Cannot add products right now; please try again later')
      end

      def reify_products(input)
        response = input[:response]
        unless response.processing?
          Representer::ProductsList.new(OpenStruct.new)
            .from_json(response.payload)
            .then { |product| input[:response] = product }
        end

        Success(input)
      rescue StandardError
        Failure('Error in the product -- please try again')
      end

      def gateway_product(poke_name, query_string)
        Gateway::Api.new(MerciDanke::App.config).products_filter(poke_name, query_string)
      end
    end
  end
end
