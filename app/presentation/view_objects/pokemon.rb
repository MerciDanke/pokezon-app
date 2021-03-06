# frozen_string_literal: true

module Views
  # View for a single pokemon entity
  class Pokemon
    def initialize(pokemon, popularities, index = nil)
      @pokemon = pokemon
      @index = index
      @popularities = popularities
    end

    def entity
      @pokemon
    end

    def poke_link
      "/products/#{poke_name}"
    end

    def poke_name
      @pokemon.poke_name
    end

    def picture
      @pokemon.front_default
    end

    def id
      @pokemon.id
    end

    def index_str
      "pokemon[#{@index}]"
    end

    def likes
      @pokemon.poke_likes
    end

    def popularity_level
      popularity = @popularities[@index]
      popularity.level if popularity.poke_id == @pokemon.origin_id
    end
  end
end
