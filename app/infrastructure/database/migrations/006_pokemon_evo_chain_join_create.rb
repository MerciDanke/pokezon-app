# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:pokemon_evolutionchain) do
      primary_key [:poke_name, :chain_species_name]
      foreign_key :poke_name, :pokemon
      foreign_key :chain_species_name, :evolutionchain

      index [:poke_name, :chain_species_name]
    end
  end
end
