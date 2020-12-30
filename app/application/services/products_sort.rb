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
        input[:response] = Gateway::Api.new(MerciDanke::App.config).products_filter(input[:poke_name], input[:query_string])
        input[:response].success? ? Success(input) : Failure(input[:response].message)
      rescue StandardError
        Failure('Cannot add products right now; please try again later')
      end

      def reify_products(input)
        unless input[:response].processing?
          Representer::ProductsList.new(OpenStruct.new)
            .from_json(input[:response].payload)
            .then { |product| input[:response] = product }
        end

        Success(input)
      rescue StandardError
        Failure('Error in the product -- please try again')
      end
    end
  end
end
