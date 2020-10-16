# frozen_string_literal: false

require_relative 'sprites'
require_relative 'species'

module PokemonInf
  # Model for Pokemon
  class Pokemon
    # def initialize(pokemon_data, species_data, sprites_source)
    #   @pokemon = pokemon_data
    #   @species = species_data
    #   @sprites_source = sprites_source
    # end
    def initialize(pokemon_data, sprites_source)
      @pokemon = pokemon_data
      @sprites_source = sprites_source
    end

    # pokemon data
    def id
      @pokemon['id']
    end

    def name
      @pokemon['name']
    end

    def type
      @pokemon['types'].map { |num| num['type']['name'] }
    end

    def abilities
      @pokemon['abilities'].map { |num| num['ability']['name'] }
    end

    def height
      @pokemon['height']
    end

    def weight
      @pokemon['weight']
    end

    # species data
    def habitat
      @species['habitat']['name']
    end

    def color
      @species['color']['name']
    end

    def flavor_text_entries
      @species['flavor_text_entries'][0]['flavor_text']
    end

    def genera
      @species['genera'][7]['genus']
    end

    def sprites
      @sprites ||= Sprites.new(@sprites_form['sprites'])
    end

    # sprites_form save pokemon-form url's data
    def sprites_form
      @sprites_form ||= @sprites_source.sprites_form(@pokemon['forms'][0]['url'])
    end
  end
end
