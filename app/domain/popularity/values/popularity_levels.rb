# frozen_string_literal: true

module MerciDanke
  module Value
    # Define popularity levels
    class PopularityLevels
      def initialize(poke_id, average_rating, products_num, poke_likes_num, products_likes_num)
        @poke_id = poke_id
        @average_rating = average_rating
        @products_num = products_num
        @poke_likes_num = poke_likes_num
        @products_likes_num = products_likes_num
      end

      def popularity_level_hash
        { poke_id: @poke_id, popularity_level: level_rules }
      end

      def level_rules
        if @average_rating > 4.5 && @products_num >= 45 && @poke_likes_num >= 10 && @products_likes_num > 5 then 'Super Hot'
        elsif @average_rating > 4.0 && @products_num >= 35 && @poke_likes_num >= 7 && @products_likes_num > 3 then 'Hot'
        elsif @average_rating > 3.5 && @products_num >= 25 && @poke_likes_num >= 4 && @products_likes_num > 1 then 'Common'
        else
          'Unpopular'
        end
      end
    end
  end
end
