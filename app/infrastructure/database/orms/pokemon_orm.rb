# frozen_string_literal: true

require 'sequel'

module MerciDanke
  module Database
    # Object Relational Mapper for Pokemon Entities
    class PokemonOrm < Sequel::Model(:pokemon)
      one_to_many :products,
                  class: :'MerciDanke::Database::ProductOrm'

      many_to_many :abilities,
                   class: :'MerciDanke::Database::AbilityOrm',
                   join_table: :pokemon_ability,
                   left_key: :poke_name, right_key: :ability_name

      many_to_many :evolutions,
                   class: :'MerciDanke::Database::EvolutionchainOrm',
                   join_table: :pokemon_evolutionchain,
                   left_key: :poke_name, right_key: :chain_species_name

      plugin :timestamps, update_on_create: true
    end
  end
end
