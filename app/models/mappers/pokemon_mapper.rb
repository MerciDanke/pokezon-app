# frozen_string_literal: false

module MerciDanke
  module Pokemon
    # Data Mapper: Pokemon intro -> Pokemon entity
    class PokemonMapper
      def initialize(gateway_class = Pokemon::Api)
        @gateway_class = gateway_class
        @gateway = @gateway_class.new
      end

      def find(poke_name)
        # data = all data
        poke_data = @gateway.poke_data(poke_name)
        pokeform_data = @gateway.pokeform_data(poke_name)
        species_data = @gateway.species_data(poke_name)
        build_entity(poke_data, pokeform_data, species_data)
      end

      def build_entity(poke_data, pokeform_data, species_data)
        DataMapper.new(poke_data, pokeform_data, species_data).build_entity
      end

      # Extracts entity specific elements from data structure
      class DataMapper
        def initialize(poke_data, pokeform_data, species_data)
          @poke_data = poke_data
          @pokeform_data = pokeform_data
          @species_data = species_data
        end

        def build_entity
          MerciDanke::Entity::Pokemon.new(
            id: id, name: name, type: type,
            abilities: abilities,
            height: height,
            weight: weight,
            back_default: back_default,
            back_shiny: back_shiny,
            front_default: front_default,
            front_shiny: front_shiny,
            habitat: habitat,
            color: color,
            flavor_text_entries: flavor_text_entrie,
            genera: genera
          )
        end

        def id
          @poke_data['id']
        end

        def name
          @poke_data['name']
        end

        def type
          @poke_data['type'].map { |element| element['type']['name'] }
        end

        def abilities
          @poke_data['abilities'].map { |element| element['ability']['name'] }
        end

        def height
          @poke_data['height']
        end

        def weight
          @poke_data['weight']
        end

        def back_default
          @pokeform_data['sprites']['back_default']
        end

        def front_default
          @pokeform_data['sprites']['front_default']
        end

        def back_shiny
          @pokeform_data['sprites']['back_shiny']
        end

        def front_shiny
          @pokeform_data['sprites']['front_shiny']
        end

        def habitat
          @species_data['habitat']['name']
        end

        def color
          @species_data['color']['name']
        end

        def flavor_text_entries
          @species_data['flavor_text_entries'][0]['flavor_text']
        end

        def genera
          @species_data['genera'][7]['genus']
        end
      end
    end
  end
end
