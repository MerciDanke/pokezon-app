# frozen_string_literal: false

module PokemonInf
  # Provides access to pokemon_sprites_id data
  class Sprites
    def initialize(sprites_data)
      @sprites = sprites_data
    end

    # back default picture
    def back_default
      @sprites['sprites']['back_default']
    end

    # back shiny picture
    def back_shiny
      @sprites['sprites']['back_shiny']
    end

    # front default picture
    def front_default
      @sprites['sprites']['front_default']
    end

    # front shiny picture
    def front_shiny
      @sprites['sprites']['front_shiny']
    end
  end
end
