# frozen_string_literal: true

module Views
  # View for a single pokemon entity
  class Product
    def initialize(product)
      @product = product
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

    def origin_id
      @product.origin_id
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
  end
end
