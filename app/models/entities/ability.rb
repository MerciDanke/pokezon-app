# frozen_string_literal: false

module MerciDanke
  module Entity
    # Domain entity for pokemons' abilities
    class Ability < Dry::Struct
      include Dry.Types
      attribute :ability_name, Strict::String
      attribute :flavor_text_entries, Strict::String
      attribute :ability_pokemons, Strict::Array.of(String)
    end
  end
end
