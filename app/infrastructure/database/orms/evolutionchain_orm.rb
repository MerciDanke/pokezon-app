# frozen_string_literal: true

require 'sequel'

module MerciDanke
  module Database
    # Object Relational Mapper for Evolutionchain Entities
    class EvolutionchainOrm < Sequel::Model(:evolutionchain)
      many_to_many :pokemons,
                   class: :'MerciDanke::Database::PokemonOrm',
                   join_table: :pokemon_evolutionchain,
                   left_key: :chain_species_name, right_key: :poke_name

      plugin :timestamps, update_on_create: true
    end
  end
end
