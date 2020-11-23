# frozen_string_literal: true

module MerciDanke
  module Mapper
    # Get the pokemon/products data from database
    class Popularities
      def initialize(pokemon, products)
        @pokemon = pokemon
        @products = products
      end

      def build_entity
        DbDataMapper.new(@pokemon, @products).build_popularity_entity
      end

      # put pokemon/products data in domain entity
      class DbDataMapper
        def initialize(pokemon, products)
          @pokemon = pokemon
          @products = products
        end

        def build_level_entity
          MerciDanke::Entity::PopularityLevel.new(@pokemon, @products)
        end

        def build_popularity_entity
          level_entity = build_level_entity
          hash = level_entity.popularity_level_hash
          # popularity_entity
          level_entity.popularity_build_entity(hash)
        end
      end
    end
  end
end
