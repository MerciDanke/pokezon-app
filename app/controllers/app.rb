# frozen_string_literal: true

require 'roda'
require 'slim'

module ProductInf
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

        routing.on String, String do |poke_name, apikey|
          # GET /products/poke_name, apikey
          routing.get do
            amazon_products = Amazon::ProjectMapper.find(poke_name, apikey)

            view 'products', locals: { search_name: poke_name, products: amazon_products }
          end
        end
      end
    end
  end
end
