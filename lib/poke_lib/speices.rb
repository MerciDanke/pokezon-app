# frozen_string_literal: false

module PokemonInf
  # Provides access to pokemon_speices_id data
  class Speices
    def initialize(speices_data)
      @speices = speices_data
    end

    def habitat
      @speices['habitat']
    end

    def color
      @speices['color']
    end

    def flavor_text_entries
      @speices['flavor_text_entries']
    end

    def genera
      @speices['genera']
    end
  end
end
