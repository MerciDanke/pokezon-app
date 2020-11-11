# frozen_string_literal: true

require 'sequel'

module MerciDanke
  module Database
    # Object Relational Mapper for Ability Entities
    class AbilityOrm < Sequel::Model(:abilities)
      many_to_many :abilities_pokemons,
                   class: :'MerciDanke::Database::PokemonOrm',
                   join_table: :pokemons_abilities,
                   left_key: :ability_id, right_key: :poke_id

      plugin :timestamps, update_on_create: true

      def self.find_or_create(ability_info)
        first(origin_id: ability_info[:origin_id]) || create(ability_info)
      end
    end
  end
end
