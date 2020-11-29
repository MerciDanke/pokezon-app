# frozen_string_literal: true

require_relative 'pokemon'

module Views
  # View for a a list of product entities
  class ProductsList
    def initialize(products)
      @products = products.map { |prod| Product.new(prod) }
    end

    def each
      @products.each do |prod|
        yield prod
      end
    end
  end
end
