# frozen_string_literal: true

require 'dry/monads/all'

module MerciDanke
  module Service
    # Retrieves array of all listed product entities
    class ListProducts
      include Dry::Monads::Result::Mixin

      def call(products_list)
        products = SearchRecord::For.klass(Entity::Product)
          .find_full_names(products_list)

        Success(products)
      rescue StandardError
        Failure('Could not access database')
      end
    end
  end
end
