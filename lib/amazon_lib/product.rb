# frozen_string_literal: false

module ProductInf
  # Model for Amazon Product
  class Product
    def initialize(product_data)
      @product = product_data
    end

    # product data
    def title
      @product['title']
    end

    def link
      @product['link']
    end

    def image
      @product['image']
    end

    def rating
      @product['rating']
    end

    def ratings_total
      @product['ratingsTotal']
    end

    def price
      @product['prices'][0]['price'].to_s
    end

    def currency
      @product['prices'][0]['currency']
    end
  end
end
