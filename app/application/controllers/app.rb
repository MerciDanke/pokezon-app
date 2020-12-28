# frozen_string_literal: false

require 'roda'
require 'slim'
require 'slim/include'
require_relative 'helpers'

module MerciDanke
  # Web App
  class App < Roda
    include RouteHelpers

    plugin :flash
    plugin :all_verbs # allows DELETE and other HTTP verbs beyond GET/POST
    plugin :render, engine: 'slim', views: 'app/presentation/view_html'
    plugin :assets, css: 'style.css', path: 'app/presentation/assets'
    plugin :halt
    plugin :caching

    use Rack::MethodOverride # for other HTTP verbs (with plugin all_verbs)

    route do |routing|
      routing.assets # load CSS

      # GET /
      routing.root do
        advance_hash = {
          :'color' => '',
          :'type_name' => '',
          :'habitat' => '',
          :'weight' => '',
          :'height' => ''
        }

        session[:watching] ||= []
        if session[:watching].count > 40
          session[:watching] = session[:watching][0..39]
        end
        result = Service::ListProducts.new.call(session[:watching])

        if result.failure?
          flash[:error] = result.failure
        else
          products = result.value!
          if products.none?
            flash.now[:notice] = 'Add a Amazon product to get started'
          end
        end

        pokemon_popularity = Service::BasicPokemonPopularity.new.call
        pokemon_all = pokemon_popularity.value!.pokemon_list
        popularity_all = pokemon_popularity.value!.popularity_list

        response.expires 60, public: true
        viewable_pokemons = Views::PokemonsList.new(pokemon_all, advance_hash, popularity_all)
        view 'home', locals: { pokemons: viewable_pokemons }
      end

      routing.on 'plus_like' do
        routing.is do
          routing.put do
            poke_id = routing.params['poke_id']
            if poke_id.nil?
              product_id = routing.params['product_id']
              Service::ProductLike.new.call(product_id)
            else
              Service::PokeomonLike.new.call(poke_id)
            end

            advance_hash = {
              :'color' => '',
              :'type_name' => '',
              :'habitat' => '',
              :'weight' => '',
              :'height' => ''
            }
            pokemon_popularity = Service::BasicPokemonPopularity.new.call
            pokemon_all = pokemon_popularity.value!.pokemon_list
            popularity_all = pokemon_popularity.value!.popularity_list

            viewable_pokemons = Views::PokemonsList.new(pokemon_all, advance_hash, popularity_all)
            view 'home', locals: { pokemons: viewable_pokemons }
          end
        end
      end

      routing.on 'pokemon' do
        routing.is do
          routing.get do
            color_name = routing.params['color'].nil? ? '' : routing.params['color'].downcase
            type_name = routing.params['type'].nil? ? '' : routing.params['type'].downcase
            habitat_name = routing.params['habitat'].nil? ? '' : routing.params['habitat'].downcase
            low_h = routing.params['low_h'].nil? ? '' : (routing.params['low_h'].downcase).to_f * 10
            high_h = routing.params['high_h'].nil? ? '' : (routing.params['high_h'].downcase).to_f * 10
            low_w = routing.params['low_w'].nil? ? '' : (routing.params['low_w'].downcase).to_f * 10
            high_w = routing.params['high_w'].nil? ? '' : (routing.params['high_w'].downcase).to_f * 10

            advance_hash = {
              :'color' => color_name,
              :'type_name' => type_name,
              :'habitat' => habitat_name,
              :'weight' => (low_w..high_w),
              :'height' => (low_h..high_h)
            }

            pokemon_popularity = Service::Advance.new.call(routing.query_string)
            pokemon_all = pokemon_popularity.value!.pokemon_list
            popularity_all = pokemon_popularity.value!.popularity_list

            viewable_pokemons = Views::PokemonsList.new(pokemon_all, advance_hash, popularity_all)
            view 'home', locals: { pokemons: viewable_pokemons }
          end
        end
      end

      routing.on 'products' do
        routing.is do
          # GET /products/
          routing.post do
            poke_name = routing.params['poke_name'].downcase
            routing.params['poke_name'] = routing.params['poke_name'].downcase
            poke_request = Forms::SearchProduct.new.call(routing.params)
            products_show = Service::ShowProducts.new.call(poke_request[:poke_name])

            if products_show.failure?
              flash[:error] = products_show.failure
              routing.redirect '/'
            end

            session[:watching].insert(0, poke_name).uniq!
            flash[:notice] = 'Pokemon added to your list'
            routing.redirect "products/#{poke_name}"
          end
        end

        routing.on String do |poke_name|
          # GET /products/poke_name, apikey
          routing.get do
            # Get pokemon and products from database
            pokemon = Service::PokemonPopularity.new.call(poke_name)
            products = Service::ShowProducts.new.call(poke_name)

            search_product = OpenStruct.new(products.value!)
            if search_product.response.processing?
              flash[:notice] = 'Product is being searched; '\
                               'please try again in a bit'
              routing.redirect '/'
            end

            pokemon_all = pokemon.value!.pokemon
            products_all = search_product.response.products

            response.expires 60, public: true
            viewable_products = Views::ProductsList.new(products_all, poke_name, pokemon_all)
            view 'products', locals: { products: viewable_products }
          end
        end
      end
    end
  end
end
