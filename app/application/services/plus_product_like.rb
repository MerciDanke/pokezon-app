# frozen_string_literal: true

require 'dry/transaction'

module MerciDanke
  module Service
    # Transaction to store product from Product API to database
    class ProductLike
      include Dry::Transaction

      step :validate_input
      step :request_productlike

      private

      def validate_input(input)
        if input.success?
          origin_id = input[:origin_id]
          Success(origin_id: origin_id)
        else
          Failure(input.errors.values.join('; '))
        end
      end

      def request_productlike(input)
        result = Gateway::Api.new(MerciDanke::App.config)
          .like_product(input[:origin_id])

        result.success? ? Success(result.payload) : Failure(result.message)
      rescue StandardError => e
        puts e.inspect + '\n' + e.backtrace
        Failure('Cannot add productlike right now; please try again later')
      end
    end
  end
end
