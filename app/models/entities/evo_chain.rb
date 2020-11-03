# frozen_string_literal: false

module MerciDanke
  module Entity
    # Domain entity for pokemons' evolution chain
    class EvoChain < Dry::Struct
      include Dry.Types

      attribute :chain_species_name, Strict::String
      attribute :evolves_to, Strict::String
      attribute :evolves_to_second, Strict::String
    end
  end
end
