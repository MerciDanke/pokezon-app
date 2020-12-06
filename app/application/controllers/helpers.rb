module MerciDanke
  module RouteHelpers
    # call all pokemons popularities
    class Popularities
      def initialize(pokemons)
        @pokemons = pokemons
      end

      def call
        popularities = []
        @pokemons.map do |pokemon|
          products = SearchRecord::For.klass(Entity::Product)
            .find_full_name(pokemon.poke_name)
          pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
            .find_full_name(pokemon.poke_name)

          popularities.push(Mapper::Popularities.new(pokemon, products).build_entity)
        end
        popularities
      end
    end
  end
end
