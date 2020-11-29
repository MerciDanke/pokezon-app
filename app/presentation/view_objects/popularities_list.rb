# frozen_string_literal: true

require_relative 'popularities'

module Views
  # View for a a list of popularities entities
  class PopularitiesList
    def initialize(popularities)
      @popularities = popularities.map.with_index { |popu, i| Popularity.new(popu, i) }
    end

    def each
      @popularities.each do |popu|
        yield popu
      end
    end

    def level
      @popularities[1].popularity_level
    end
  end
end
