# frozen_string_literal: true

module MerciDanke
  module SearchRecord
    # Finds the right pokemon for an entity object or class
    class ForPoke
      ENTITY_REPOSITORY = {
        Entity::Pokemon => Pokemons
      }.freeze

      def self.klass(entity_klass)
        ENTITY_REPOSITORY[entity_klass]
      end

      def self.entity(entity_object)
        ENTITY_REPOSITORY[entity_object.class]
      end
    end
  end
end
