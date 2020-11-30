# frozen_string_literal: true

module Views
  # View for a single popularity entity
  class Popularity
    def initialize(popularity, index = nil)
      @popularity = popularity
      @index = index
    end

    def entity
      @popularity
    end

    def level
      @popularity.popularity_level
    end

    def poke_id
      @popularity.poke_id
    end

    def index_str
      "popularity[#{@index}]"
    end
  end
end
