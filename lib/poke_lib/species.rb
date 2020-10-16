# frozen_string_literal: false

module PokemonInf
  # Provides access to pokemon_species_id data
  class Species
    def initialize(species_data)
      @species = species_data
    end

    def habitat
      @species['habitat']
    end

    def color
      @species['color']
    end

    def flavor_text_entries
      @species['flavor_text_entries']
    end

    def genera
      @species['genera']
    end
  end
end
