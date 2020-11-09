# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:pokemon_ability) do
      primary_key [:poke_name, :ability_name]
      foreign_key :poke_name, :pokemon
      foreign_key :ability_name, :ability

      index [:poke_name, :ability_name]
    end
  end
end
