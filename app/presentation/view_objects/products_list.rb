# frozen_string_literal: true

require_relative 'product'

module Views
  # View for a a list of product entities
  class ProductsList
    def initialize(products, search, pokemon)
      @products = products.map.with_index { |prod, index| Product.new(prod, index) }
      @search = search
      @pokemon = pokemon
    end

    def each
      @products.each do |prod|
        yield prod
      end
    end

    def search
      @search
    end

    def front_img
      @pokemon.front_default
    end

    def back_img
      @pokemon.back_default
    end

    def front_img_second
      @pokemon.front_shiny
    end

    def back_img_second
      @pokemon.back_shiny
    end

    def height
      @pokemon.height
    end

    def weight
      @pokemon.weight
    end

    def color
      @pokemon.color
    end

    def habitat
      @pokemon.habitat
    end

    def genera
      @pokemon.genera
    end

    def types
      @pokemon.types
    end

    def text
      @pokemon.flavor_text_entries
    end

    def abilities
      @pokemon.abilities
    end

    def evochain_first
      @pokemon.evochain.chain_species_name
    end

    def evochain_second
      @pokemon.evochain.evolves_to
    end

    def evochain_third
      @pokemon.evochain.evolves_to_second
    end
  end
end
