# frozen_string_literal: true

require 'dry/transaction'

module MerciDanke
  module Service
    # Transaction to store product from Amazon API to database
    class BasicPokemonPopularity
      include Dry::Transaction

      step :request_pokemons
      step :reify_pokemons

      private

      def request_pokemons
        result = Gateway::Api.new(MerciDanke::App.config).all_pokemon
        result.success? ? Success(result.payload) : Failure(result.message)
      rescue StandardError => e
        puts e.inspect + '\n' + e.backtrace
        Failure('Cannot add products right now; please try again later')
      end

      def reify_pokemons(pokemons_json)
        Representer::BasicPokemonList.new(OpenStruct.new)
          .from_json(pokemons_json)
          .then { |pokemon| Success(pokemon) }
      rescue StandardError
        Failure('Error in the pokemons -- please try again')
      end
    end
  end
end
