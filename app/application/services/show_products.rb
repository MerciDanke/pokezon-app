# frozen_string_literal: true

require 'dry/transaction'

module MerciDanke
  module Service
    # Transaction to store product from Amazon API to database
    class ShowProducts
      include Dry::Transaction

      step :validate_input
      step :request_products
      step :reify_products

      private

      def validate_input(input)
        if input.success?
          poke_name = input[:remote_url].split('/')
          Success(poke_name: poke_name)
        else
          Failure(input.errors.values.join('; '))
        end
      end

      def request_products(input)
        result = Gateway::Api.new(MerciDanke::App.config)
          .add_product(input[:poke_name])

        result.success? ? Success(result.payload) : Failure(result.message)
      rescue StandardError => e
        puts e.inspect + '\n' + e.backtrace
        Failure('Cannot add products right now; please try again later')
      end

      def reify_products(products_json)
        Representer::Product.new(OpenStruct.new)
          .from_json(products_json)
          .then { |product| Success(product) }
      rescue StandardError
        Failure('Error in the product -- please try again')
      end
    end
  end
end
