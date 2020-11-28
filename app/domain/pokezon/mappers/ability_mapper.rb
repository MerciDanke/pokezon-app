# frozen_string_literal: false

module MerciDanke
  module Pokemon
    # Data Mapper: Ability intro -> Ability entity
    class AbilityMapper
      def initialize(gateway_class = Pokemon::Api)
        @gateway_class = gateway_class
        @gateway = @gateway_class.new
      end

      def find_by_url(ability_url)
        # data = all data
        ability_data = @gateway.ability_data(ability_url)
        AbilityMapper.build_entity(ability_data)
      end

      def self.build_entity(ability_data)
        DataMapper.new(ability_data).build_entity
      end

      # Extracts entity specific elements from data structure
      class DataMapper
        def initialize(ability_data)
          @ability_data = ability_data
        end

        def build_entity
          MerciDanke::Entity::Ability.new(
            id: nil,
            origin_id: origin_id,
            ability_name: ability_name,
            flavor_text_entries: flavor_text_entries,
            ability_pokemons: ability_pokemons
          )
        end

        def ability_name
          @ability_data['name']
        end

        def origin_id
          @ability_data['id']
        end

        def ability_pokemons
          @ability_data['pokemon'].map { |num| num['pokemon']['name'] }
        end

        def flavor_text_entries
          @ability_data['flavor_text_entries'][0]['flavor_text']
        end
      end
    end
  end
end
