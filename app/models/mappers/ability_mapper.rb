# frozen_string_literal: false

module MerciDanke
  module Pokemon
    # Data Mapper: Ability intro -> Ability entity
    class AbilityMapper
      def initialize(gateway_class = Pokemon::Api)
        @gateway_class = gateway_class
        @gateway = @gateway_class.new
      end

      def find(ability_id)
        # data = all data
        ability_data = @gateway.ability_data(ability_id)
        build_entity(ability_data)
      end

      def build_entity(ability_data)
        DataMapper.new(ability_data).build_entity
      end

      # Extracts entity specific elements from data structure
      class DataMapper
        def initialize(ability_data)
          @ability_data = ability_data
        end

        def build_entity
          MerciDanke::Entity::Ability.new(
            name: name,
            flavor_text_entries: flavor_text_entries,
            pokemon: pokemon
          )
        end

        def name
          @ability_data['name']
        end

        def pokemon
          @ability_data['pokemon'].map { |num| num['pokemon']['name'] }
        end

        def flavor_text_entries
          @ability_data['flavor_text_entries'][0]['flavor_text']
        end
      end
    end
  end
end
