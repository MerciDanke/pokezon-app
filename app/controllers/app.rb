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
        low_h = ''
        high_h = ''
        low_w = ''
        high_w = ''

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
                                low_h: low_h,
                                high_h: high_h,
                                low_w: low_w,
                                high_w: high_w,
                                popularities: popularities }
      end

      routing.on 'plus_like' do
        routing.is do
          routing.post do
            color_name = ''
            type_name = ''
            habitat_name = ''
            low_h = ''
            high_h = ''
            low_w = ''
            high_w = ''
            poke_id = routing.params['poke_id']
            SearchRecord::ForPoke.klass(Entity::Pokemon).plus_like(poke_id)
            pokemon_all = SearchRecord::ForPoke.klass(Entity::Pokemon).all
            popularities = []
            pokemon_all.map do |poke|
              products = SearchRecord::For.klass(Entity::Product)
                .find_full_name(poke.poke_name)

              pokemon_pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_full_name(poke.poke_name)

              popularities.push(Mapper::Popularities.new(pokemon_pokemon, products).build_entity)
            end
            view 'home', locals: { color_name: color_name,
                                   pokemon: pokemon_all,
                                   type_name: type_name,
                                   habitat_name: habitat_name,
                                   low_h: low_h,
                                   high_h: high_h,
                                   low_w: low_w,
                                   high_w: high_w,
                                   popularities: popularities }
          end
        end
      end

      routing.on 'type' do
        routing.is do
          routing.post do
            color_name = routing.params['color_name'].nil? ? '' : routing.params['color_name'].downcase
            type_name = routing.params['type_name'].nil? ? '' : routing.params['type_name'].downcase
            habitat_name = routing.params['habitat_name'].nil? ? '' : routing.params['habitat_name'].downcase
            low_h = routing.params['low_h'].nil? ? '' : routing.params['low_h'].downcase
            high_h = routing.params['high_h'].nil? ? '' : routing.params['high_h'].downcase
            low_w = routing.params['low_w'].nil? ? '' : routing.params['low_w'].downcase
            high_w = routing.params['high_w'].nil? ? '' : routing.params['high_w'].downcase
            # 1 situations(5)
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
            if low_h != '' && high_h != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_height(low_h, high_h)
            end
            if low_w != '' && high_w != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_weight(low_w, high_w)
            end
            # 2 situations(10)
            if color_name != '' && type_name != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_color_type(color_name, type_name)
            end
            if habitat_name != '' && type_name != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_type_habitat(type_name, habitat_name)
            end
            if habitat_name != '' && color_name != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_color_habitat(color_name, habitat_name)
            end
            if low_h != '' && high_h != '' && type_name != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_height_type(low_h, high_h, type_name)
            end
            if low_h != '' && high_h != '' && color_name != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_height_color(low_h, high_h, color_name)
            end
            if low_h != '' && high_h != '' && habitat_name != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_height_habitat(low_h, high_h, habitat_name)
            end
            if low_w != '' && high_w != '' && type_name != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_weight_type(low_w, high_w, type_name)
            end
            if low_w != '' && high_w != '' && color_name != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_weight_color(low_w, high_w, color_name)
            end
            if low_w != '' && high_w != '' && habitat_name != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_weight_habitat(low_w, high_w, habitat_name)
            end
            if low_h != '' && high_h != '' && low_w != '' && high_w != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_height_weight(low_h, high_h, low_w, high_w)
            end
            # 3 situations(10)
            if habitat_name != '' && color_name != '' && type_name != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_habitat_color_type(habitat_name, color_name, type_name)
            end
            if habitat_name != '' && color_name != '' && low_h != '' && high_h != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_habitat_color_height(habitat_name, color_name, low_h, high_h)
            end
            if habitat_name != '' && color_name != '' && low_w != '' && high_w != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_habitat_color_weight(habitat_name, color_name, low_w, high_w)
            end
            if habitat_name != '' && type_name != '' && low_h != '' && high_h != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_habitat_type_height(habitat_name, type_name, low_h, high_h)
            end
            if habitat_name != '' && type_name != '' && low_w != '' && high_w != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_habitat_type_weight(habitat_name, type_name, low_w, high_w)
            end
            if color_name != '' && type_name != '' && low_h != '' && high_h != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_color_type_height(color_name, type_name, low_h, high_h)
            end
            if color_name != '' && type_name != '' && low_w != '' && high_w != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_color_type_weight(color_name, type_name, low_w, high_w)
            end
            if type_name != '' && low_h != '' && high_h != '' && low_w != '' && high_w != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_type_height_weight(type_name, low_h, high_h, low_w, high_w)
            end
            if color_name != '' && low_h != '' && high_h != '' && low_w != '' && high_w != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_color_height_weight(color_name, low_h, high_h, low_w, high_w)
            end
            if habitat_name != '' && low_h != '' && high_h != '' && low_w != '' && high_w != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_habitat_height_weight(habitat_name, low_h, high_h, low_w, high_w)
            end
            # 4 situations(5)
            if habitat_name != '' && type_name != '' && low_h != '' && high_h != '' && low_w != '' && high_w != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_habitat_type_height_weight(habitat_name, type_name, low_h, high_h, low_w, high_w)
            end
            if habitat_name != '' && color_name != '' && low_h != '' && high_h != '' && low_w != '' && high_w != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_habitat_color_height_weight(habitat_name, color_name, low_h, high_h, low_w, high_w)
            end
            if type_name != '' && color_name != '' && low_h != '' && high_h != '' && low_w != '' && high_w != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_type_color_height_weight(type_name, color_name, low_h, high_h, low_w, high_w)
            end
            if type_name != '' && color_name != '' && habitat_name != '' && low_h != '' && high_h != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_type_color_habitat_weight(type_name, color_name, habitat_name, low_h, high_h)
            end
            if type_name != '' && color_name != '' && habitat_name != '' && low_w != '' && high_w != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_type_color_habitat_weight(type_name, color_name, habitat_name, low_w, high_w)
            end
            # 5 situation
            if type_name != '' && color_name != '' && habitat_name != '' && low_h != '' && high_h != '' && low_w != '' && high_w != ''
              pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_type_color_habitat_height_weight(type_name, color_name, habitat_name, low_h, high_h, low_w, high_w)
            end
            popularities = []
            pokemon.map do |poke|
              products = SearchRecord::For.klass(Entity::Product)
                .find_full_name(poke.poke_name)

              pokemon_pokemon = SearchRecord::ForPoke.klass(Entity::Pokemon)
                .find_full_name(poke.poke_name)

              popularities.push(Mapper::Popularities.new(pokemon_pokemon, products).build_entity)
            end

            view 'home', locals: { color_name: color_name,
                                   pokemon: pokemon,
                                   type_name: type_name,
                                   habitat_name: habitat_name,
                                   low_h: low_h,
                                   high_h: high_h,
                                   low_w: low_w,
                                   high_w: high_w,
                                   popularities: popularities }
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

          routing.post do
            product_id = routing.params['product_id']
            product_like = SearchRecord::For.klass(Entity::Product).plus_like(product_id)
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
