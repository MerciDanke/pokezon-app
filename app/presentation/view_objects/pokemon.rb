# frozen_string_literal: true

module Views
  # View for a single pokemon entity
  class Pokemon
    def initialize(pokemon, index = nil)
      @pokemon = pokemon
      @index = index
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

    def index_str
      "pokemon[#{@index}]"
    end

    def picture
      @pokemon.front_default
    end

    def id
      @pokemon.id
    end

    def likes
      @pokemon.poke_likes
    end
  end
end
