# frozen_string_literal: true

require 'sequel'

module MerciDanke
  module Database
    # Object Relational Mapper for Ability Entities
    class AbilityOrm < Sequel::Model(:ability)
      many_to_many :pokemons,
                   class: :'MerciDanke::Database::PokemonOrm',
                   join_table: :pokemon_ability,
                   left_key: :ability_name, right_key: :poke_name

      plugin :timestamps, update_on_create: true
    end
  end
end
