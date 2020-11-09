# frozen_string_literal: true

module MerciDanke
  module SearchRecord #不確定pokemon和amazon要不要合在一起的module
    # Repository for Pokemon Entities
    class Pokemons
      def self.all
        Database::PokemonOrm.all.map { |db_project| rebuild_entity(db_project) }
      end

      def self.find_full_name(poke_name)
        # SELECT * FROM `projects` LEFT JOIN `members`
        # ON (`members`.`id` = `projects`.`owner_id`)
        # WHERE ((`username` = 'owner_name') AND (`name` = 'project_name'))
        db_pokezon = Database::PokemonOrm
          .left_join(:product, poke_name: :poke_name)
          .where(poke_name: poke_name)
          .first
        rebuild_entity(db_pokezon)
      end

      def self.find(entity)
        find_origin_id(entity.id)
      end

      def self.find_origin_id(id)
        db_record = Database::PokemonOrm.first(id: id)
        rebuild_entity(db_record)
      end

      def self.create(entity)
        raise 'Pokezon already exists' if find(entity)

        db_new_pokezon = PersistPokezon.new(entity).call
        rebuild_entity(db_new_pokezon)
      end

      private

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::Pokezon.new(
          db_record.to_hash.merge(
            owner: Members.rebuild_entity(db_record.owner),
            contributors: Members.rebuild_many(db_record.contributors)
          )
        )
      end

      # Helper class to persist project and its members to database
      class PersistPokezon
        def initialize(entity)
          @entity = entity
        end

        def create_project
          Database::PokezonOrm.create(@entity.to_attr_hash)
        end

        def call
          owner = Products.db_find_or_create(@entity.owner)

          create_project.tap do |db_project|
            db_project.update(owner: owner)

            @entity.contributors.each do |contributor|
              db_project.add_contributor(Members.db_find_or_create(contributor))
            end
          end
        end
      end
    end
  end
end
