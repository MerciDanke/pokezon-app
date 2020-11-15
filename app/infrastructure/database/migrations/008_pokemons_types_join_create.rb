# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:pokemons_types) do
      primary_key [:poke_id, :type_id]
      foreign_key :poke_id, :pokemons
      foreign_key :type_id, :types

      index [:poke_id, :type_id]
    end
  end
end
