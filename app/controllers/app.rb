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
        color_name = ''
        type_name = ''
        habitat_name = ''
        height1 = ''
        height2 = ''
        weight1 = ''
        weight2 = ''

        5.times do |num|
          break if Database::PokemonOrm.find(id: 5)

          pokemon = Pokemon::PokemonMapper.new.find((num + 1).to_s)
          SearchRecord::ForPoke.entity(pokemon).create(pokemon)
        end

        pokemon_all = SearchRecord::ForPoke.klass(Entity::Pokemon).all

        2.times do |num|
          break unless SearchRecord::For.klass(Entity::Product).all.length.zero?
          amazon_products = Amazon::ProductMapper.new.find(pokemon_all[num].poke_name, MerciDanke::App.config.API_KEY)
          amazon_products.map do |product|
            SearchRecord::For.entity(product).create(product)
          end
        end

        popularities = []
        pokemon_all.map do |pokemon|
          products = SearchRecord::For.klass(Entity::Product)
            .find_full_name(pokemon.poke_name)

          pokemon_pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
            .find_full_name(pokemon.poke_name)

          popularities.push(Mapper::Popularities.new(pokemon_pokemon, products).build_entity)
        end

        view 'home', locals: {  pokemon: pokemon_all,
                                color_name: color_name,
                                type_name: type_name,
                                habitat_name: habitat_name,
                                height1: height1,
                                height2: height2,
                                weight1: weight1,
                                weight2: weight2,
                                popularities: popularities }
      end

      routing.on 'type' do
        routing.is do
          # GET /products/
          routing.post do
            color_name = routing.params['color_name'].nil? ? '' : routing.params['color_name'].downcase
            type_name = routing.params['type_name'].downcase
            habitat_name = routing.params['habitat_name'].downcase
            height1 = routing.params['height1'].downcase
            height2 = routing.params['height2'].downcase
            weight1 = routing.params['weight1'].downcase
            weight2 = routing.params['weight2'].downcase
            # 1 situatuion
            if type_name != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_type(type_name)
            end
            if color_name != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_color(color_name)
            end
            if habitat_name != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_habitat(habitat_name)
            end
            if height1 != '' && height2 != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_height(height1, height2)
            end
            if weight1 != '' && weight2 != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_weight(weight1, weight2)
            end
            # 2 situatuions
            if color_name != '' && type_name != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_color_and_type(color_name, type_name)
            end
            if habitat_name != '' && type_name != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_type_and_habitat(type_name, habitat_name)
            end
            if habitat_name != '' && color_name != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_color_and_habitat(color_name, habitat_name)
            end
            if height1 != '' && height2 != '' && type_name != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_height_and_type(height1, height2, type_name)
            end
            if height1 != '' && height2 != '' && color_name != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_height_and_color(height1, height2, color_name)
            end
            if height1 != '' && height2 != '' && habitat_name != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_height_and_habitat(height1, height2, habitat_name)
            end
            if weight1 != '' && weight2 != '' && type_name != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_weight_and_type(weight1, weight2, type_name)
            end
            if weight1 != '' && weight2 != '' && color_name != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_weight_and_color(weight1, weight2, color_name)
            end
            if weight1 != '' && weight2 != '' && habitat_name != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_weight_and_habitat(weight1, weight2, habitat_name)
            end
            if height1 != '' && height2 != '' && weight1 != '' && weight2 != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_height_and_weight(height1, height2, weight1, weight2)
            end
            # 3 situatuions
            if habitat_name != '' && color_name != '' && type_name != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_type_and_color_and_habitat(type_name, color_name, habitat_name)
            end
            # 4 situatuions
            # 5 situatuions
            view 'home', locals: { color_name: color_name, pokemon: pokemon, type_name: type_name, habitat_name: habitat_name, height1: height1, height2: height2, weight1: weight1, weight2: weight2 }
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

            puts amazon_products
            # ADD product to DataBase
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
