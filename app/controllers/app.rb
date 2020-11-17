# frozen_string_literal: true

require 'roda'
require 'slim'

module MerciDanke
  # Web App
  class App < Roda
    plugin :render, engine: 'slim', views: 'app/views'
    plugin :assets, css: 'style.css', path: 'app/views/assets'
    plugin :halt

    route do |routing|
      routing.assets # load CSS

      # GET /
      routing.root do
        color_name = {}
        type_name = {}
        pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon).all
        20.times do |i|
          break if Database::PokemonOrm.find(id: 20)
          pokemon_all = Pokemon::PokemonMapper.new.find((i + 1).to_s)
          SearchRecord::ForPoke.entity(pokemon_all).create(pokemon_all)
        end
        view 'home', locals: { pokemon: pokemon, color_name: color_name, type_name: type_name }
      end

      routing.on 'color' do
        routing.is do
          # GET /products/
          routing.post do
            color_name = routing.params['color_name'].downcase
            pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
              .find_color_name(color_name)
            type_name = {}
            view 'home', locals: { color_name: color_name, pokemon: pokemon, type_name: type_name }
          end
        end
      end
      routing.on 'type' do
        routing.is do
          # GET /products/
          routing.post do
            type_name = routing.params['type_name'].downcase
            pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
              .find_type_name(type_name)
            puts pokemon
            color_name = {}
            view 'home', locals: { type_name: type_name, pokemon: pokemon, color_name: color_name }
          end
        end
      end
      routing.on 'products' do
        routing.is do
          # GET /products/
          routing.post do
            poke_name = routing.params['poke_name'].downcase

            # GET product from amazon
            amazon_products = Amazon::ProductMapper.new.find(poke_name, MerciDanke::App.config.API_KEY)
            pokemon_pokemon = Pokemon::PokemonMapper.new.find(poke_name)
            # ADD product to DB
            amazon_products.map do |product|
              SearchRecord::For.entity(product).create(product)
            end
            SearchRecord::ForPoke.entity(pokemon_pokemon).create(pokemon_pokemon)
            # Redirect viewer to product page
            routing.redirect "products/#{poke_name}"
            # routing.redirect "product/#{product.title}"
          end
        end

        routing.on String do |poke_name|
          # GET /products/poke_name, apikey
          routing.get do
            # amazon_products = Amazon::ProductMapper.new.find(poke_name, API_KEY)
            amazon_products = SearchRecord::For.klass(Entity::Product)
              .find_full_name(poke_name)
            # pokemon_pokemon = Pokemon::PokemonMapper.new.find(poke_name)
            pokemon_pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
              .find_full_name(poke_name)
            view 'products', locals: { search_name: poke_name, products: amazon_products, pokemon: pokemon_pokemon }
          end
        end
      end
    end
  end
end
