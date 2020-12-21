# frozen_string_literal: true

require_relative 'pokemon'
require_relative 'popularity'

module Views
  # View for a list of pokemon entities
  class PokemonsList
    def initialize(pokemons, advance_hash, popularities)
      @popularities = popularities.map.with_index { |popu, i| Popularity.new(popu, i) }
      @pokemons = pokemons.map.with_index { |poke, i| Pokemon.new(poke, i, @popularities)}
      @advance_hash = advance_hash
    end

    def each
      @pokemons.each do |poke|
        yield poke
      end
    end

    def any?
      @pokemons.any?
    end

    def advance_hash
      @advance_hash
    end
  end
end
