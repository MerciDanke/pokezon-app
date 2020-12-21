# frozen_string_literal: true

require 'dry/transaction'

module MerciDanke
  module Service
    # Transaction to store product from Amazon API to database
    class Advance
      include Dry::Transaction

      step :validate_input
      step :request_pokemons
      step :reify_products

      private

      def validate_input(input)
        if input
          advance_list = input
          Success(advance_list: advance_list)
        else
          Failure('Could not find that advance list!')
        end
      end

      def request_pokemons(input)
        result = Gateway::Api.new(MerciDanke::App.config)
          .advance_list(input[:advance_list])
        result.success? ? Success(result.payload) : Failure(result.message)
      rescue StandardError => e
        puts e.inspect + '\n' + e.backtrace
        Failure('Cannot add products right now; please try again later')
      end

      def reify_products(pokemons_json)
        Representer::BasicPokemonList.new(OpenStruct.new)
          .from_json(pokemons_json)
          .then { |pokemon| Success(pokemon) }
      rescue StandardError
        Failure('Error in the pokemon -- please try again')
      end
    end
  end
end
