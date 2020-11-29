# frozen_string_literal: true

require_relative 'pokemon'
require_relative 'popularity'

module Views
  # View for a list of pokemon entities
  class PokemonsList
    def initialize(pokemons, color, type, habitat, low_h, high_h, low_w, high_w, popularities)
      @pokemons = pokemons.map.with_index { |poke, i| Pokemon.new(poke, i) }
      @color = color
      @type = type
      @habitat = habitat
      @low_h = low_h
      @high_h = high_h
      @low_w = low_w
      @high_w = high_w
      @popularities = popularities.map.with_index { |popu, i| Popularity.new(popu, i) }
    end

    def each
      @pokemons.each do |poke|
        yield poke
      end
    end

    def any?
      @pokemons.any?
    end

    def type
      @type
    end

    def habitat
      @habitat
    end

    def color
      @color
    end

    def low_h
      @low_h
    end

    def high_h
      @high_h
    end

    def low_w
      @low_w
    end

    def high_w
      @high_w
    end
  end
end
