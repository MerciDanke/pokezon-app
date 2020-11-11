# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:pokemons_evochains) do
      primary_key [:poke_id, :evochain_id]
      foreign_key :poke_id, :pokemons
      foreign_key :evochain_id, :evochains

      index [:poke_id, :evochain_id]
    end
  end
end
