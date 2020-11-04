# frozen_string_literal: false

module ProductInf
  module Amazon
    # Data Mapper: Amazon product -> Product entity
    class ProductMapper
      def initialize(gateway_class = Amazon::Api)
        @gateway_class = gateway_class
        @gateway = @gateway_class.new
      end

      def find(poke_name, apikey)
        data = @gateway.product_data(poke_name, apikey)
        puts data
        # all data
        build_entity(data['results'])
      end

      def build_entity(data)
        DataMapper.new(data).build_entity
      end

      # Extracts entity specific elements from data structure
      class DataMapper
        def initialize(data)
          @data = data
        end

        def build_entity
          ProductInf::Entity::Product.new(
            id: nil,
            title: title,
            link: link,
            image: image,
            rating: rating,
            ratings_total: ratings_total,
            currency: currency,
            raw_price: raw_price
          )
        end

        def title
          @data['title']
        end

        def link
          @data['link']
        end

        def image
          @data['image']
        end

        def ratings_total
          @data['ratingsTotal']
        end

        def rating
          @data['rating']
        end

        def currency
          @data['currency']
        end

        def raw_price
          @data['rawPrice']
        end
      end
    end
  end
end
