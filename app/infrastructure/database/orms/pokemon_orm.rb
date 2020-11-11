# frozen_string_literal: true

require 'sequel'

module MerciDanke
  module Database
    # Object Relational Mapper for Pokemon Entities
    class PokemonOrm < Sequel::Model(:pokemons)
      many_to_one :evochain,
                   class: :'MerciDanke::Database::EvochainOrm'

      many_to_many :abilities,
                   class: :'MerciDanke::Database::AbilityOrm',
                   join_table: :pokemons_abilities,
                   left_key: :poke_id, right_key: :ability_id

      plugin :timestamps, update_on_create: true
    end
  end
end
