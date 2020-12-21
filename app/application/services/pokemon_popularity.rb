# frozen_string_literal: true

require 'dry/transaction'

module MerciDanke
  module Service
    # Transaction to store pokemons from Pokemons API to database
    class PokemonPopularity
      include Dry::Transaction

      step :validate_input
      step :request_pokemons
      step :reify_pokemons

      private

      def validate_input(input)
        if input
          poke_name = input
          Success(poke_name: poke_name)
        else
          Failure(input.errors.values.join('; '))
        end
      end

      def request_pokemons(input)
        result = Gateway::Api.new(MerciDanke::App.config)
          .add_pokemon(input[:poke_name])

        result.success? ? Success(result.payload) : Failure(result.message)
      rescue StandardError => e
        puts e.inspect + '\n' + e.backtrace
        Failure('Cannot add pokemons right now; please try again later')
      end

      def reify_pokemons(pokemons_json)
        Representer::PokemonPopularity.new(OpenStruct.new)
          .from_json(pokemons_json)
          .then { |pokemon| Success(pokemon) }
      rescue StandardError
        Failure('Error in the pokemon -- please try again')
      end
    end
  end
end
