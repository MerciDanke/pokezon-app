# frozen_string_literal: true

require 'sequel'

module MerciDanke
  module Database
    # Object Relational Mapper for Product Entities
    class ProductOrm < Sequel::Model(:products)
      # many_to_one :pokemon,
      #             class: :'MerciDanke::Database::PokemonOrm'

      plugin :timestamps, update_on_create: true
    end
  end
end
