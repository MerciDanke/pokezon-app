# frozen_string_literal: true

require 'dry/transaction'

module MerciDanke
  module Service
    # Transaction to store product from Amazon API to database
    class ShowProducts
      include Dry::Transaction

      step :find_pokemon
      step :find_products
      step :store_products

      private

      def find_pokemon(input)
        pokemon = correct_pokemon_name(input)
        Success(pokemon)
      rescue StandardError
        Failure('Could not find that pokemon!')
      end

      def find_products(input)
        get_products = Array.new(2)
        if (products = products_in_database(input[:poke_name]))
          get_products[0] = products
        else
          get_products[1] = products_in_amazon(input[:poke_name])
        end
        Success(get_products)
      rescue StandardError
        Failure('Amazon products have some unknown problems. Please try again!')
      end

      def store_products(input)
        products =
          if (new_prods = input[1])
            new_prods.map { |prod| SearchRecord::For.entity(prod).create(prod) }
          else
            input[0]
          end
        Success(products)
      rescue StandardError => error
        puts error.backtrace.join("\n")
        Failure('Having trouble accessing the database')
      end

      # following are support methods that other services could use

      def products_in_amazon(input)
        Amazon::ProductMapper.new.find(input, MerciDanke::App.config.API_KEY)
      end

      def correct_pokemon_name(input)
        Pokemon::PokemonMapper.new.find(input[:poke_name])
      end

      public

      def products_in_database(input)
        SearchRecord::For.klass(Entity::Product)
          .find_full_name(input)
      end
    end
  end
end
