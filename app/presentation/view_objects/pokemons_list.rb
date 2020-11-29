# frozen_string_literal: true

require_relative 'pokemon'

module Views
  # View for a a list of pokemon entities
  class PokemonsList
    def initialize(pokemons)
      @pokemons = pokemons.map.with_index { |poke, i| Pokemon.new(poke, i) }
    end

    def each
      @pokemons.each do |poke|
        yield poke
      end
    end

    def any?
      @pokemons.any?
    end
  end
end
