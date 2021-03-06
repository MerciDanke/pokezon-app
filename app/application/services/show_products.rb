# frozen_string_literal: true

require 'dry/transaction'

module MerciDanke
  module Service
    # Transaction to store products from Products API to database
    class ShowProducts
      include Dry::Transaction

      step :validate_input
      step :request_products
      step :reify_products

      private

      def validate_input(input)
        if input
          poke_name = input
          Success(poke_name: poke_name)
        else
          Failure('Could not find that pokemon!')
        end
      end

      def request_products(input)
        input[:response] = Gateway::Api.new(MerciDanke::App.config).add_product(input[:poke_name])
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
    end
  end
end
