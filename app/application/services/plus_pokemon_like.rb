# frozen_string_literal: true

require 'dry/transaction'

module MerciDanke
  module Service
    # Transaction to store pokeomon from Pokemon API to database
    class PokeomonLike
      include Dry::Transaction

      step :validate_input
      step :request_pokeomonlike

      private

      def validate_input(input)
        if input
          id = input[:id]
          Success(id: id)
        else
          Failure(input.errors.values.join('; '))
        end
      end

      def request_pokeomonlike(input)
        result = Gateway::Api.new(MerciDanke::App.config)
          .like_pokemon(input[:id])

        result.success? ? Success(result.payload) : Failure(result.message)
      rescue StandardError => e
        puts e.inspect + '\n' + e.backtrace
        Failure('Cannot add pokeomonlike right now; please try again later')
      end
    end
  end
end
