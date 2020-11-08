# frozen_string_literal: true

module MerciDanke
  module SearchRecord
    # Repository for Project Entities
    class Products
      def self.all
        Database::ProductOrm.all.map { |db_product| rebuild_entity(db_product) }
      end

      def self.find_full_name(poke_name)
        # SELECT * FROM `projects` LEFT JOIN `members`
        # ON (`members`.`id` = `projects`.`owner_id`)
        # WHERE ((`username` = 'owner_name') AND (`name` = 'project_name'))
        db_product = Database::ProductOrm
          .where(poke_name: poke_name)
          .first              #是只會吐第一個回來嗎?
        rebuild_entity(db_product)
      end

      def self.find(entity)
        find_origin_id(entity.origin_id)
      end

      def self.find_id(id)
        db_record = Database::ProductOrm.first(id: id)
        rebuild_entity(db_record)
      end

      def self.find_origin_id(origin_id)
        db_record = Database::ProductOrm.first(origin_id: origin_id)
        rebuild_entity(db_record)
      end

      def self.create(entity)
        raise 'Product already exists' if find(entity)

        db_product = PersistProduct.new(entity).create_product
        rebuild_entity(db_product)
      end

      private

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::Product.new(
          db_record.to_hash.merge
          # db_record.to_hash.merge(
          #   owner: Members.rebuild_entity(db_record.owner),
          #   contributors: Members.rebuild_many(db_record.contributors)
          # )
        )
      end

      # Helper class to persist project and its members to database
      class PersistProduct
        def initialize(entity)
          @entity = entity
        end

        def create_product
          Database::ProductOrm.create(@entity.to_attr_hash)
        end

        # def call
        #   owner = Members.db_find_or_create(@entity.owner)

        #   create_product.map do |db_product|
        #     db_product.update(owner: owner)

        #     @entity.contributors.each do |contributor|
        #       db_project.add_contributor(Members.db_find_or_create(contributor))
        #     end
        #   end
        # end
      end
    end
  end
end
