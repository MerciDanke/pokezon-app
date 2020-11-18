# frozen_string_literal: true

module MerciDanke
  module Calculate
    # each pokemon's popularity calculation method
    module PopularityCalculator
      # 老師有attr_reader :file_path, :lines在entities/file_contributions.rb
      # one pokemon's all products average rating
      def average_rating(products)
        all_ratings = products.reduce { |l, r| l.rating + r.rating }
        (all_ratings / pruducts_num).round
      end

      # one pokemon can search how many products
      def products_num(products)
        products.length
      end

      # one pokemon's likes count
      def poke_likes_num(pokemon)
        pokemon.poke_likes
      end

      # one pokemon's all products likes count
      def products_likes_num(products)
        products.reduce { |l, r| l.product_likes + r.product_likes }
      end
    end
  end
end
