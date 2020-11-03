# frozen_string_literal: false

require_relative 'ability'

module MerciDanke
  module Entity
    # Domain entity for pokemons
    class Pokemon < Dry::Struct
      include Dry.Types

      attribute :id, Strict::Integer
      attribute :name, Strict::String
      attribute :type, Strict::Array.of(String)
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
      # EvoChain
      attribute :evo_chains, EvoChain
      # Ability
      attribute :abilities, Strict::Array.of(Ability)
    end
  end
end
