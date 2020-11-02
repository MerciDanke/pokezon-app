# frozen_string_literal: false

module MerciDanke
  module Pokemon
    # Data Mapper: evolution chain intro -> evolution chain entity
    class EvoMapper
      def initialize(gateway_class = Pokemon::Api)
        @gateway_class = gateway_class
        @gateway = @gateway_class.new
      end

      def find(evo_id)
        # data = all data
        evo_data = @gateway.evo_data(evo_id)
        build_entity(evo_data)
      end

      def build_entity(evo_data)
        DataMapper.new(evo_data).build_entity
      end

      # Extracts entity specific elements from data structure
      class DataMapper
        def initialize(evo_data)
          @evo_data = evo_data
        end

        def build_entity
          MerciDanke::Entity::EvoChain.new(
            chain_species_name: chain_species_name,
            evolves_to: evolves_to,
            evolves_to_second: evolves_to_second
          )
        end

        def chain_species_name
          @evolution_chain['chain']['species']['name']
        end

        def evolves_to
          @evolution_chain['chain']['evolves_to'][0]['species']['name']
        end

        def evolves_to_second
          ev_second = @evolution_chain['chain']['evolves_to'][0]['evolves_to']
          ['species']['name'] if ev_second[0]
        end
      end
    end
  end
end
