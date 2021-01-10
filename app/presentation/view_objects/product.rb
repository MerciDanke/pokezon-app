# frozen_string_literal: true

module Views
  # View for a single pokemon entity
  class Product
    def initialize(product, index = nil)
      @product = product
      @index = index
    end

    def entity
      @product
    end

    def price
      @product.price
    end

    def rating
      @product.rating
    end

    def poke_name
      @product.poke_name
    end

    def link
      @product.link
    end

    def id
      @product.id
    end

    def likes
      @product.product_likes
    end

    def title
      @product.title
    end

    def image
      @product.image
    end

    def index_str
      "product[#{@index}]"
    end
  end
end
