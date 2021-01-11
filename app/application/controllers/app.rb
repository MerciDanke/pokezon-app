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
        session[:watching] = session[:watching][0..39] if session[:watching].count > 40
        result = Service::ListProducts.new.call(session[:watching])

        if result.failure?
          flash[:error] = result.failure
        else
          products = result.value!
          flash.now[:notice] = 'Add a Amazon product to get started' if products.none?
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
            low_h = routing.params['low_h'].nil? ? '' : routing.params['low_h'].to_f
            high_h = routing.params['high_h'].nil? ? '' : routing.params['high_h'].to_f
            low_w = routing.params['low_w'].nil? ? '' : routing.params['low_w'].to_f
            high_w = routing.params['high_w'].nil? ? '' : routing.params['high_w'].to_f
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
          # POST /products/
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

            if routing.query_string.length.zero?
              products = Service::ShowProducts.new.call(poke_name)
            else
              input = {
                :'poke_name' => poke_name,
                :'query_string' => routing.query_string
              }
              products = Service::ProductSort.new.call(input)
            end

            search_product = OpenStruct.new(products.value!)
            if search_product.response.processing?
              flash.now[:notice] = 'The Products are being searched'
            else
              pokemon_all = pokemon.value!.pokemon
              products_all = search_product.response.products
              viewable_products = Views::ProductsList.new(products_all, poke_name, pokemon_all)
              response.expires(60, public: true) if App.environment == :produciton
            end

            processing = Views::ProductsProcessing.new(
              App.config, search_product.response
            )

            # Show viewer the products
            view 'products', locals: { products: viewable_products, processing: processing }
          end
        end
      end
    end
  end
end
