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
        view 'home'
      end

      routing.on 'products' do
        routing.is do
          # GET /products/
          routing.post do
            poke_name = routing.params['poke_name'].downcase
            routing.redirect "products/#{poke_name}"
          end
        end

        routing.on String do |poke_name|
          # GET /products/poke_name, apikey
          routing.get do
            amazon_products = Amazon::ProductMapper.new.find(poke_name, API_KEY)
            pokemon_pokemon = Pokemon::PokemonMapper.new.find(poke_name)
            # pokemon_evolution = Pokemon::EvoMapper.new.find(evo_id)
            # pokemon_ability = Pokemon::AbilityMapper.new.find(ability_id)
            view 'products', locals: { search_name: poke_name, products: amazon_products, pokemon: pokemon_pokemon }
          end
        end
      end
    end
  end
end
