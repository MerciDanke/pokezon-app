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
        products = SearchRecord::For.klass(Entity::Product).all
        view 'home', locals: { products: products }
      end

      routing.on 'products' do
        routing.is do
          # GET /products/
          routing.post do
            poke_name = routing.params['poke_name'].downcase

            # GET product from amazon
            amazon_products = Amazon::ProductMapper.new.find(poke_name, API_KEY)

            # ADD product to DB
            amazon_products.map do |product|
              SearchRecord::For.entity(product).create(product)
            end
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
            pokemon_pokemon = Pokemon::PokemonMapper.new.find(poke_name)

            view 'products', locals: { search_name: poke_name, products: amazon_products, pokemon: pokemon_pokemon }
          end
        end
      end
    end
  end
end
