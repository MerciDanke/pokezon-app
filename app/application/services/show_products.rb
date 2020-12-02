# frozen_string_literal: true

require 'dry/transaction'

module MerciDanke
  module Service
    # Transaction to store product from Amazon API to database
    class ShowProducts
      include Dry::Transaction

      step :find_pokemon
      step :find_product
      step :store_product

      private

      def find_pokemon(input)
        pokemon_pokemon = pokemon_in_database(input)
        Success(pokemon_pokemon)
      rescue StandardError
        Failure('Could not find that pokemon!')
      end

      def find_product(input)
        puts input[:poke_name]
        input[:remote_products] = Amazon::ProductMapper.new.find(input[:poke_name], MerciDanke::App.config.API_KEY)

        Success(input)
      rescue StandardError
        Failure('Amazon products have some unknown problems. Please try again!')
      end

      def store_product(input)
        product =
          if (new_prods = input[:remote_products])
            new_prods.map do |prod|
              SearchRecord::For.entity(prod).create(prod)
            end
            pokemon_pokemon = pokemon_in_database(input)
            SearchRecord::ForPoke.entity(pokemon_pokemon).create(pokemon_pokemon)
          end
        puts "3", product
        Success(product)
      rescue StandardError => error
        puts error.backtrace.join("\n")
        Failure('Having trouble accessing the database')
      end

      # following are support methods that other services could use

      # def product_from_amazon(input)
      #   products = []
      #   products.push(Amazon::ProductMapper
      #     .new.find(input[:poke_name], MerciDanke::App.config.API_KEY))
      #   return products
      # rescue StandardError
      #   raise 'Could not find that product on Amazon'
      # end

      def pokemon_in_database(input)
        Pokemon::PokemonMapper.new.find(input[:poke_name])
      end
    end
  end
end
