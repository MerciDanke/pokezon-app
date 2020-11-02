# frozen_string_literal: false

module MerciDanke
  module Entity
    # Domain entity for any coding projects
    class Product < Dry::Struct
      include Dry.Types

      attribute :id,        Integer.optional
      attribute :title,     Strict::String
      attribute :link,      Strict::String
      attribute :image,     Strict::String
      attribute :rating,    Strict::Float
      attribute :ratings_total, Strict::Integer
      attribute :currency, Strict::String
      attribute :price, Strict::String
    end

    # Domain entity for pokemons
    class Pokemon < Dry::Struct
      include Dry.Types

      attribute :id, Strict::Integer
      attribute :name, Strict::String
      attribute :type, Strict::String
      attribute :abilities, Strict::String
      attribute :height, Strict::Integer
      attribute :weight, Strict::Integer
      attribute :back_default, Strict::String
      attribute :back_shiny, Strict::String
      attribute :front_default, Strict::String
      attribute :front_shiny, Strict::String
      attribute :habitat, Strict::String
      attribute :color, Strict::String
      attribute :flavor_text_entries, Strict::String
      attribute :genera, Strict::String
    end

    # Domain entity for pokemons' abilities
    class Ability < Dry::Struct
      include Dry.Types

      attribute :name, Strict::String
      attribute :flavor_text_entries, Strict::String
      attribute :pokemon, Strict::String
    end

    # Domain entity for pokemons' evolution chain
    class EvoChain < Dry::Struct
      include Dry.Types

      attribute :chain_species_name, Strict::String
      attribute :evolves_to, Strict::String
      attribute :evolves_to_second, Strict::String
    end
  end
end
