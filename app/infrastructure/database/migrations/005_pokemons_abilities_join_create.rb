# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:pokemons_abilities) do
      primary_key [:poke_id, :ability_id]
      foreign_key :poke_id, :pokemons
      foreign_key :ability_id, :abilities

      index [:poke_id, :ability_id]
    end
  end
end
